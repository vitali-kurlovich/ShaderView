//
//  RMVector.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVector.h"

#import "RMMath.h"


@interface RMVector2 ()
{
    NSUInteger _hash;
}

@end

@implementation RMVector2

- (instancetype)init
{
    return [self initWithX:0 y:0];
}

- (instancetype)initWithX:(float)x y:(float)y
{
    self = [super init];
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


- (NSUInteger)hash
{
    if (_hash == 0)
    {
        const NSUInteger prime = 31;
        _hash = 1;
        
        _hash = prime * _hash + _hash*_vector.x;
        _hash = prime * _hash + _hash*_vector.y;
    }
    return _hash;
}


- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    else if ([self class] == [object class])
    {
        return [self isEqualToVector2:object];
    }
    return NO;
}

- (BOOL)isEqualToVector2:(RMVector2*)vec
{
    if (vec == nil)
    {
        return NO;
    }
    return self == vec || ( self->_vector.x == vec->_vector.x && self->_vector.y == vec->_vector.y);
}


@end


@interface RMVector3 ()
{
    NSUInteger _hash;
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
    self = [super init];
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

- (NSUInteger)hash
{
    if (_hash == 0)
    {
        const NSUInteger prime = 31;
        _hash = 1;
        
        _hash = prime * _hash + _hash*_vector.x;
        _hash = prime * _hash + _hash*_vector.y;
        _hash = prime * _hash + _hash*_vector.z;
    }
    return _hash;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    else if ([self class] == [object class])
    {
        return [self isEqualToVector3:object];
    }
    return NO;
}

- (BOOL)isEqualToVector3:(RMVector3*)vec
{
    if (vec == nil)
    {
        return NO;
    }
    return self == vec || ( self->_vector.x == vec->_vector.x && self->_vector.y == vec->_vector.y && self->_vector.z == vec->_vector.z);
}

@end


@interface RMVector4 ()
{
    NSUInteger _hash;
}

@end

@implementation RMVector4

- (instancetype)init
{
    return [self initWithX:0 y:0 z:0 w:0];
}

- (instancetype)initWithX:(float)x y:(float)y z:(float)z w:(float)w
{
    self = [super init];
    if (self)
    {
        _vector.x = x;
        _vector.y = y;
        _vector.z = z;
        _vector.w = w;
    }
    return self;
}

+ (instancetype)vectorWithX:(float)x y:(float)y z:(float)z w:(float)w
{
    return [[[self class] alloc] initWithX:x y:y z:z w:w];
}


+ (instancetype)vectorWithRMVector:(_RMVector4)vector
{
    return [[[self class] alloc] initWithX:vector.x y:vector.y z:vector.z w:vector.w];
}

- (NSUInteger)hash
{
    if (_hash == 0)
    {
        const NSUInteger prime = 31;
        _hash = 1;
        
        _hash = prime * _hash + _hash*_vector.x;
        _hash = prime * _hash + _hash*_vector.y;
        _hash = prime * _hash + _hash*_vector.z;
        _hash = prime * _hash + _hash*_vector.w;
    }
    return _hash;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    else if ([self class] == [object class])
    {
        return [self isEqualToVector4:object];
    }
    return NO;
}

- (BOOL)isEqualToVector4:(RMVector4*)vec
{
    if (vec == nil)
    {
        return NO;
    }
    return self == vec || ( self->_vector.x == vec->_vector.x &&
                           self->_vector.y == vec->_vector.y &&
                           self->_vector.z == vec->_vector.z &&
                           self->_vector.w == vec->_vector.w
                           );
}

@end

