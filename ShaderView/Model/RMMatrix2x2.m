//
//  RMMatrix2x2.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMatrix2x2.h"


static unsigned int const kM00 = 0;
static unsigned int const kM01 = 1;
static unsigned int const kM10 = 2;
static unsigned int const kM11 = 3;

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
        _matrix[kM00] = 1;
        _matrix[kM10] = 1;
    }
    return self;
}

+ (nullable instancetype)matrix
{
    return [[RMMatrix2x2 alloc] initWithType:RMMatrixType2x2];
}


- (float)m00
{
    return _matrix[kM00];
}

- (void)setM00:(float)m00
{
    _matrix[kM00] = m00;
}

- (float)m01
{
    return _matrix[kM01];
}

- (void)setM01:(float)m01
{
    _matrix[kM01] = m01;
}

- (float)m10
{
    return _matrix[kM10];
}

- (void)setM10:(float)m10
{
    _matrix[kM10] = m10;
}

- (float)m11
{
    return _matrix[kM11];
}

- (void)setM11:(float)m11
{
    _matrix[kM11] = m11;
}

@end
