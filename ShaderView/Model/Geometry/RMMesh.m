//
//  RMMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//



#import "RMMesh.h"

#import "RMProgram.h"

#import "RMVBOObject.h"
#import "RMVBOObject+RMDrawable.h"

@implementation RMMesh

- (void)draw
{
    [self.program useProgramBegin];
    [self.program prepareForUseVBOBuffer:self.vbo.vertexBuffer];
    [self.vbo draw];
    [self.program useProgramEnd];
}

@end




