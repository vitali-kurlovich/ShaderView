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


+ (nonnull instancetype)mesh
{
    return [[[self class] alloc] init];
}

+ (nonnull instancetype)meshWithVBO:(RMVBOObject*)vbo program:(RMProgram*)program
{
    return [[[self class] alloc] initWithVBO:vbo program:program];
}

+ (nonnull instancetype)meshWithVBO:(RMVBOObject*)vbo
{
    return [[[self class] alloc] initWithVBO:vbo];
}


- (instancetype)initWithVBO:(RMVBOObject*)vbo program:(RMProgram*)program
{
    self = [super init];
    if (self)
    {
        _vbo = vbo;
        _program = program;
    }
    return self;
}

- (instancetype)initWithVBO:(RMVBOObject*)vbo
{
    return [self initWithVBO:vbo program:nil];
}

- (instancetype)init
{
    return [self initWithVBO:nil];
}

@end




