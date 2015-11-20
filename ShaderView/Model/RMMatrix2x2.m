//
//  RMMatrix2x2.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMatrix2x2.h"


@interface RMMatrix2x2 ()
{
    float _matrix[2*2];
}

@end

@implementation RMMatrix2x2

- (const float*)matrix
{
    return _matrix;
}

- (instancetype)initWithType:(RMMatrixType)type
{
    if (RMMatrixType2x2 != type)
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
    return [[RMMatrix2x2 alloc] initWithType:RMMatrixType2x2];
}


@end
