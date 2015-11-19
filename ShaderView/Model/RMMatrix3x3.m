//
//  RMMatrix3x3.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMatrix3x3.h"


static unsigned int const kM00 = 0;
static unsigned int const kM01 = 1;
static unsigned int const kM02 = 2;

static unsigned int const kM10 = 3;
static unsigned int const kM11 = 4;
static unsigned int const kM12 = 5;

static unsigned int const kM20 = 6;
static unsigned int const kM21 = 7;
static unsigned int const kM22 = 8;


@interface RMMatrix3x3 ()
{
    float _matrix[3*3];
}

@end

@implementation RMMatrix3x3

- (const float*)matrix
{
    return _matrix;
}

- (instancetype)initWithType:(RMMatrixType)type
{
    if (RMMatrixType3x3 != type)
    {
        return nil;
    }
    self = [super initWithType:type];
    if (self)
    {
        _matrix[kM00] = 1;
        _matrix[kM11] = 1;
        _matrix[kM22] = 1;
    }
    return self;
}

+ (nullable instancetype)matrix
{
    return [[RMMatrix3x3 alloc] initWithType:RMMatrixType3x3];
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