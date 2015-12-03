//
//  RMTestRender3DScene.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTestRender3DScene.h"

#import "RMGLSLProgram.h"

@implementation RMTestRender3DScene

+ (Class)programClass
{
    return [RMGLSLProgram class];
}

@end
