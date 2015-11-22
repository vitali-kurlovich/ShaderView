//
//  RMFragmentShader.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMFragmentShader.h"



@implementation RMFragmentShader : RMShader

- (nullable instancetype)initWithSource:(nonnull NSString*)source
{
    self = [super initWithType:RMShaderTypeFragment source:source];
    return self;
}
@end