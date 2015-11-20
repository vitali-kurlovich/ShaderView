//
//  RMGLRender.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLRender.h"

@import OpenGLES;

@interface RMGLRender ()
{
    struct {
        GLuint colorRenderBuffer;
        unsigned int colorRenderBufferWasCreated:1;
        
        GLuint depthRenderBuffer;
        unsigned int depthRenderBufferWasCreated:1;
        
        GLuint frameBuffer;
        unsigned int frameBufferWasCreated:1;
        
    } _renderBuffers;
}

@end

@implementation RMGLRender


- (void)configureViewportWithX:(float)x y:(float)y  width:(float)width height:(float)height
{
    glViewport(x, y, width, height);
}

- (void)prepareRenderBuffersWithWidth:(float)width height:(float)height
{
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
    }
    
    glGenRenderbuffers(1, &_renderBuffers.colorRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffers.colorRenderBuffer);
    _renderBuffers.colorRenderBufferWasCreated = 1;
    
    
    glGenRenderbuffers(1,  &_renderBuffers.depthRenderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER,  _renderBuffers.depthRenderBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, width, height);
    
    _renderBuffers.depthRenderBufferWasCreated = 1;
    
    glGenFramebuffers(1, &_renderBuffers.frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _renderBuffers.frameBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _renderBuffers.colorRenderBuffer);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, _renderBuffers.depthRenderBuffer);
    
    _renderBuffers.frameBufferWasCreated = 1;
}


- (void)preRender:(rmtime)deltaTime
{

    [super preRender:deltaTime];
    
    glClearColor(0.8, 0.3, 0.3, 1);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  //  glEnable(GL_DEPTH_TEST);
    
}




- (void)render:(rmtime)deltaTime
{
 
    
    
}


@end
