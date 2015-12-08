//
//  RMGLTestRenderViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/27/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLTestRenderViewController.h"

@implementation RMGLTestRenderViewController


- (void)renderView:(RMRenderView*)renderView  preRenderWithDuration:(rmtime)deltaTime
{
    [self.render renderView:renderView preRenderWithDuration:deltaTime];
}

- (void)renderView:(RMRenderView*)renderView  postRenderWithDuration:(rmtime)deltaTime
{
    [self.render renderView:renderView postRenderWithDuration:deltaTime];
}

- (void)renderView:(RMRenderView*)renderView  renderWithDuration:(rmtime)deltaTime
{
    [self.render renderView:renderView renderWithDuration:deltaTime];
}


@end
