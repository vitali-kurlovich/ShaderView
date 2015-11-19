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



- (const float*)matrix
{
    return NULL;
}

#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

#pragma mark - NSMutableCopying
- (id)mutableCopyWithZone:(nullable NSZone *)zone
{
    return [[RMMatrix alloc] initWithType:self.type];
}

@end





@interface RMMatrix4x4 ()
{
    float _matrix[4*4];
}

@end

@implementation RMMatrix4x4

- (const float*)matrix
{
    return _matrix;
}

- (instancetype)initWithType:(RMMatrixType)type
{
    if (RMMatrixType4x4 != type)
    {
        return nil;
    }
    self = [super initWithType:type];
    if (self)
    {
        _matrix[0] = 1;
        _matrix[5] = 1;
        _matrix[10] = 1;
        _matrix[15] = 1;
    }
    return self;
}

+ (nullable instancetype)matrix
{
    return [[RMMatrix4x4 alloc] initWithType:RMMatrixType4x4];
}


@end