//
//  RMGLShaderView.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLShaderView.h"

#import "RMGLRender.h"

@import OpenGLES;

@interface RMGLShaderView()
@property (nonatomic, readonly) CAEAGLLayer* eaglLayer;


@property (nonatomic, readonly) EAGLContext* context;

@end

@implementation RMGLShaderView
@synthesize eaglLayer = _eaglLayer;
@synthesize glRender = _glRender;

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
        EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES3;
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
    
    [self.context renderbufferStorage:GL_RENDERBUFFER fromDrawable:self.eaglLayer];
}

- (RMRender*)render
{
    return self.glRender;
}

- (RMGLRender*)glRender
{
    if (_glRender == nil)
    {
        _glRender = [[RMGLRender alloc] init];
    }
    return _glRender;
}

- (void)postRender:(rmtime)deltaTime
{
    [super postRender:deltaTime];
    
    [self.context presentRenderbuffer:GL_RENDERBUFFER];
}


@end
