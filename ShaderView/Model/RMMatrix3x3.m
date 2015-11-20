//
//  RMMatrix3x3.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMatrix3x3.h"


@interface RMMatrix3x3 ()

@end

@implementation RMMatrix3x3


- (instancetype)initWithType:(RMMatrixType)type
{
    if (RMMatrixType3x3 != type)
    {
        return nil;
    }
    self = [super initWithType:type];
    if (self)
    {

    }
    return self;
}

+ (nullable instancetype)matrix
{
    return [[RMMatrix3x3 alloc] initWithType:RMMatrixType3x3];
}




@end