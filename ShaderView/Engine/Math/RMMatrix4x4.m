//
//  RMMatrix4x4.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMatrix4x4.h"


@interface RMMatrix4x4 ()

@end

@implementation RMMatrix4x4

- (instancetype)initWithType:(RMMatrixType)type
{
    if (RMMatrixType4x4 != type)
    {
        return nil;
    }
    self = [super initWithType:type];
    if (self)
    {
        _matrix = kRMIdentityMatrix4x4;
    }
    return self;
}

+ (nullable instancetype)matrix
{
    return [[RMMatrix4x4 alloc] initWithType:RMMatrixType4x4];
}

- (nullable instancetype)initWithMatrix:(_RMMatrix4x4)matrix
{
    self = [self initWithType:RMMatrixType4x4];
    if (self)
    {
        _matrix = matrix;
    }
    return self;
}


+ (nullable instancetype)translateMatrixWithX:(float)x y:(float)y
{
    return [[[self class] alloc] initWithMatrix:RMTranslateMatrix4x4(x,y,0)];
}

+ (nullable instancetype)translateMatrixWithX:(float)x y:(float)y z:(float)z
{
    return [[[self class] alloc] initWithMatrix:RMTranslateMatrix4x4(x,y,z)];
}

+ (nullable instancetype)scaleMatrixWithX:(float)x y:(float)y
{
    return [[[self class] alloc] initWithMatrix:RMScaleMatrix4x4(x,y,0)];
}

+ (nullable instancetype)scaleMatrixWithX:(float)x y:(float)y z:(float)z
{
    return [[[self class] alloc] initWithMatrix:RMScaleMatrix4x4(x,y,z)];
}

+ (nullable instancetype)rotateMatrixWithAngle:(float)angle
{
    return [[[self class] alloc] initWithMatrix:RMRotateMatrix4x4(angle, 0,0,1)];
}

+ (nullable instancetype)rotateMatrixWithAngle:(float)angle x:(float)x y:(float)y z:(float)z
{
    
    return [[[self class] alloc] initWithMatrix:RMRotateMatrix4x4(angle, x,y,z)];
}


- (nullable instancetype)mul:(nullable RMMatrix4x4*)matrix
{
    _RMMatrix4x4 result = RMMulMatrix4x4(_matrix, matrix.matrix);
    
    return [[[self class] alloc] initWithMatrix:result];
}

- (nullable instancetype)inverse
{
    BOOL sucess;
     _RMMatrix4x4 result =  RMInverseMatrix4x4(_matrix, &sucess);
    
    if (sucess)
    {
        return [[[self class] alloc] initWithMatrix:result];
    }
    return nil;
}

- (instancetype)transpose
{
    return [[[self class] alloc] initWithMatrix:RMTransposeMatrix4x4(_matrix)];
}

@end
