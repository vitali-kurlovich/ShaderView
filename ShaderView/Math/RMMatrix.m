//
//  RMMatrix.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

#import "RMMatrix.h"



@implementation RMMatrix

- (instancetype)init
{
    return [self initWithType:RMMatrixTypeNone];
}

- (instancetype)initWithType:(RMMatrixType)type
{
    if (RMMatrixTypeNone == type)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
    
        _type = type;
    }
    return self;
}


+ (nullable instancetype)matrix
{
    return nil;
}

+ (nullable instancetype)translateMatrixWithX:(float)x y:(float)y
{
    return nil;
}

+ (nullable instancetype)translateMatrixWithX:(float)x y:(float)y z:(float)z
{
    return nil;
}


+ (nullable instancetype)scaleMatrixWithX:(float)x y:(float)y
{
    return nil;
}

+ (nullable instancetype)scaleMatrixWithX:(float)x y:(float)y z:(float)z
{
    return nil;
}

+ (nullable instancetype)rotateMatrixWithAngle:(float)angle
{
    return nil;
}

+ (nullable instancetype)rotateMatrixWithAngle:(float)angle x:(float)x y:(float)y z:(float)z
{
    return nil;
}


- (nullable instancetype)mul:(nullable RMMatrix*)matrix
{
    return nil;
}


#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}



@end

