//
//  RMVertexShader.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVertexShader.h"

@implementation RMVertexShader : RMShader

- (nullable instancetype)initWithSource:(nonnull NSString*)source attributes:( nullable NSArray<RMVertexAttribute*>*)attributes
{
    self = [super initWithType:RMShaderTypeVertex source:source];
    
    if (self)
    {
        _attributes = [attributes copy];
    }
    return self;
}

- (nullable instancetype)initWithSource:(nonnull NSString*)source
{
    return [self initWithSource:source attributes:nil];
}

+ (nullable instancetype)shader:(nonnull NSString*)source attributes:(nullable NSArray<RMVertexAttribute*>*)attributes
{
    return [[[self class] alloc] initWithSource:source attributes:attributes];
}

@end