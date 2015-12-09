//
//  RMRenderVBO.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/8/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMRenderVBO.h"
#import "RMVBOObject.h"

#import "RMProgram.h"

@implementation RMRenderVBO


- (void)preRender
{
    [super preRender];
    [self.program prepareForUseVBOBuffer:self.vbo.vertexBuffer];
}


@end
