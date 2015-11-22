//
//  RMGLPostProcessingRender.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLPostProcessingRender.h"

@import OpenGLES;

@implementation RMGLPostProcessingRender

- (void)preRender:(rmtime)deltaTime
{
    [super preRender:deltaTime];
    glClearColor(0.8, 0.3, 0.3, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glDisable(GL_DEPTH_TEST);
}

- (void)render:(rmtime)deltaTime
{
    
}



@end
