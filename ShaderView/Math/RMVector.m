//
//  RMVector.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVector.h"

#import "RMMath.h"

@implementation RMVector

- (instancetype)init
{
    return [self initWithType:RMVectorTypeNone];
}

- (instancetype)initWithType:(RMVectorType)type
{
    if (RMVectorTypeNone == type)
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


@end


@implementation RMVector2

- (instancetype)init
{
    return [self initWithX:0 y:0];
}

- (instancetype)initWithX:(float)x y:(float)y
{
    self = [super initWithType:RMVectorType2];
    if (self)
    {
        _vector.x = x;
        _vector.y = y;
    }
    return self;
}

+ (instancetype)vectorWithX:(float)x y:(float)y
{
    return [[[self class] alloc] initWithX:x y:y];
}

+ (nonnull instancetype)vectorWithRMVector:(_RMVector2)vector
{
    return [[[self class] alloc] initWithX:vector.x y:vector.y];
}

@end





@implementation RMVector3

- (instancetype)init
{
    return [self initWithX:0 y:0 z:0];
}

- (instancetype)initWithX:(float)x y:(float)y
{
    return [self initWithX:x y:y z:0];
}

- (instancetype)initWithX:(float)x y:(float)y z:(float)z
{
    self = [super initWithType:RMVectorType3];
    if (self)
    {
        _vector.x = x;
        _vector.y = y;
        _vector.z = z;
    }
    return self;
}

+ (instancetype)vectorWithX:(float)x y:(float)y z:(float)z
{
    return [[[self class] alloc] initWithX:x y:y z:z];
}

+ (instancetype)vectorWithX:(float)x y:(float)y
{
    return [[[self class] alloc] initWithX:x y:y];
}

+ (nonnull instancetype)vectorWithRMVector:(_RMVector3)vector
{
    return [[[self class] alloc] initWithX:vector.x y:vector.y z:vector.z];
}

@end