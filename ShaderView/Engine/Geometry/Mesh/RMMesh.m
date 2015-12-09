//
//  RMMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//



#import "RMMesh.h"



@implementation RMMesh

+ (nonnull instancetype)mesh
{
    return [[[self class] alloc] init];
}


+ (nonnull instancetype)meshWithVBO:(RMVBOObject*)vbo
{
    return [[[self class] alloc] initWithVBO:vbo];
}


- (instancetype)initWithVBO:(RMVBOObject*)vbo
{
    self = [super init];
    if (self)
    {
        _vbo = vbo;
    }
    return self;
}


- (instancetype)init
{
    return [self initWithVBO:nil];
}

@end




