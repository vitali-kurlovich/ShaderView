//
//  RMVertexShader.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVertexShader.h"

@implementation RMVertexShader : RMShader

- (nullable instancetype)initWithSource:(nonnull NSString*)source
{
    self = [super initWithType:RMShaderTypeVertex source:source];
    return self;
}

@end