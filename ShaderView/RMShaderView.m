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
@synthesize render = _render;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _configureDisplayLink];
       
       
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _configureDisplayLink];
       
    }
    return self;
}

- (RMRender*)render
{
    if (_render == nil)
    {
        _render = [[RMRender alloc] init];
    }
    return _render;
}


- (void)_render:(CADisplayLink*)displayLink
{    
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
    [self.render postRender:deltaTime];
}

- (void)render:(rmtime)deltaTime
{
     [self.render render:deltaTime];
}

@end
