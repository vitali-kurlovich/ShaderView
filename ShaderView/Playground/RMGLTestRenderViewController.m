//
//  RMGLTestRenderViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/27/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLTestRenderViewController.h"

@implementation RMGLTestRenderViewController


- (void)renderView:(RMRenderView*)render  preRenderWithDuration:(rmtime)deltaTime
{
    [self.render preRender:nil duration:deltaTime];
}

- (void)renderView:(RMRenderView*)render  postRenderWithDuration:(rmtime)deltaTime
{
    [self.render postRender:nil duration:deltaTime];
}

- (void)renderView:(RMRenderView*)render  renderWithDuration:(rmtime)deltaTime
{
    [self.render render:nil duration:deltaTime];
}


@end
