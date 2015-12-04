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
    self = [super initWithType:RMVectorType2];
    if (self)
    {
        _vector.x = x;
        _vector.y = y;
        
        _hash = [self _hash];
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


- (NSUInteger)_hash
{
    const NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + self.type;
    result = prime * result + result*_vector.x;
    result = prime * result + result*_vector.y;
    
    return result;
}

- (NSUInteger)hash {
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
    self = [super initWithType:RMVectorType3];
    if (self)
    {
        _vector.x = x;
        _vector.y = y;
        _vector.z = z;
        
        _hash = [self _hash];
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

- (NSUInteger)_hash
{
    const NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + self.type;
    result = prime * result + result*_vector.x;
    result = prime * result + result*_vector.y;
    result = prime * result + result*_vector.z;
    return result;
}

- (NSUInteger)hash {
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
    self = [super initWithType:RMVectorType4];
    if (self)
    {
        _vector.x = x;
        _vector.y = y;
        _vector.z = z;
        _vector.w = w;
        
        _hash = [self _hash];
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

- (NSUInteger)_hash
{
    const NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + self.type;
    result = prime * result + result*_vector.x;
    result = prime * result + result*_vector.y;
    result = prime * result + result*_vector.z;
    result = prime * result + result*_vector.w;
    return result;
}

- (NSUInteger)hash {
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

