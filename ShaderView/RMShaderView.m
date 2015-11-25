//
//  RMShaderView.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMShaderView.h"

#import "RMRender.h"

@import OpenGLES;

@interface RMShaderView ()

@end

@implementation RMShaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _configureDisplayLink];
        self.render.delegate = self;
       
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _configureDisplayLink];
        self.render.delegate = self;
    }
    return self;
}


- (void)setFrame:(CGRect)frame
{
    if (!CGRectEqualToRect(self.frame, frame))
    {
        super.frame = frame;
        float scale = [UIScreen mainScreen].scale;
        [self.render prepareRenderBuffersWithWidth:CGRectGetWidth(frame)*scale height:CGRectGetHeight(frame)*scale];
    }
}


- (void)_render:(CADisplayLink*)displayLink
{
    float scale = [UIScreen mainScreen].scale;
    [self.render configureViewportWithX:CGRectGetMinX(self.bounds)*scale
                                      y:CGRectGetMinY(self.bounds)*scale
                                  width:CGRectGetWidth(self.bounds)*scale
                                 height:CGRectGetHeight(self.bounds)*scale];
    
    [self preRender:displayLink.duration];
    [self render:displayLink.duration];
    [self postRender:displayLink.duration];
}

- (void)_configureDisplayLink {
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_render:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}


- (void)preRender:(rmtime)deltaTime
{
    [self.render preRender:deltaTime];
}

- (void)postRender:(rmtime)deltaTime
{
    [self.render render:deltaTime];
}

- (void)render:(rmtime)deltaTime
{
     [self.render postRender:deltaTime];
}

@end
