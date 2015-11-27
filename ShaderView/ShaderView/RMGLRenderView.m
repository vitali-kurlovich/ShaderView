//
//  RMGLShaderView.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLRenderView.h"

#import "RMRender.h"

@import OpenGLES;

@interface RMGLRenderView()
{
    struct {
        GLuint colorRenderBuffer;
        unsigned int colorRenderBufferWasCreated:1;
        
        GLuint depthRenderBuffer;
        unsigned int depthRenderBufferWasCreated:1;
        
        GLuint frameBuffer;
        unsigned int frameBufferWasCreated:1;
        
    } _renderBuffers;
    
    GLuint _depthRenderBuffer;
    GLuint _colorRenderBuffer;
}

@property (nonatomic, readonly) CAEAGLLayer* eaglLayer;
@property (nonatomic, readonly) EAGLContext* context;

@end

@implementation RMGLRenderView
@synthesize eaglLayer = _eaglLayer;


+ (Class)layerClass {
    return [CAEAGLLayer class];
}

- (CAEAGLLayer*)eaglLayer
{
    if (_eaglLayer == nil)
    {
        _eaglLayer = (CAEAGLLayer*) self.layer;
        _eaglLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking:@NO,
                                          kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8};
        self.contentScaleFactor = [UIScreen mainScreen].scale;
    }
    return _eaglLayer;
}

@synthesize context = _context;

- (EAGLContext*)context
{
    if (_context == nil)
    {
        EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
        _context = [[EAGLContext alloc] initWithAPI:api];
        if (!_context) {
            NSLog(@"Failed to initialize OpenGLES 3.0 context");
            exit(1);
        }
        
        if (![EAGLContext setCurrentContext:_context]) {
            NSLog(@"Failed to set current OpenGL context");
            exit(1);
        }
    }
    
    return _context;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    float scale = [UIScreen mainScreen].scale;
    float width = CGRectGetWidth(frame)*scale;
    float height = CGRectGetHeight(frame)*scale;
    
    [self prepareRenderBuffersWithWidth:width height:height];
    
    glViewport(0, 0, width, height);
}



- (void)prepareRenderBuffersWithWidth:(float)width height:(float)height
{
    
     [self context];
    
    if (_renderBuffers.colorRenderBufferWasCreated)
    {
        glDeleteRenderbuffers(1, &_renderBuffers.colorRenderBuffer);
        _renderBuffers.colorRenderBufferWasCreated = 0;
    }
    
    if (_renderBuffers.depthRenderBufferWasCreated)
    {
        glDeleteRenderbuffers(1, &_renderBuffers.depthRenderBuffer);
        _renderBuffers.depthRenderBufferWasCreated = 0;
    }
    
    if(_renderBuffers.frameBufferWasCreated)
    {
        glDeleteRenderbuffers(1, &_renderBuffers.frameBuffer);
        _renderBuffers.frameBufferWasCreated = 0;
    }
    
    
    if (!_renderBuffers.depthRenderBufferWasCreated)
    {
        glGenRenderbuffers(1,  &_renderBuffers.depthRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER,  _renderBuffers.depthRenderBuffer);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, width, height);
        
        _renderBuffers.depthRenderBufferWasCreated = 1;
    }
    
    if (!_renderBuffers.colorRenderBufferWasCreated)
    {
        glGenRenderbuffers(1, &_renderBuffers.colorRenderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffers.colorRenderBuffer);
        _renderBuffers.colorRenderBufferWasCreated = 1;
        
        [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.eaglLayer];
    }
    
    if (!_renderBuffers.frameBufferWasCreated) {
        
        glGenFramebuffers(1, &_renderBuffers.frameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, _renderBuffers.frameBuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderBuffers.colorRenderBuffer);
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _renderBuffers.depthRenderBuffer);
        
        _renderBuffers.frameBufferWasCreated = 1;
        
    }
}



- (void)postRender:(rmtime)deltaTime
{
    [super postRender:deltaTime];
    
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
}


@end
