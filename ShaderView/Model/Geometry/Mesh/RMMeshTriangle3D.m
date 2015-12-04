//
//  RMMeshTriangle3D.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/4/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMeshTriangle3D.h"

#import "RMMeshVertex3D.h"


@interface RMMeshTriangle3D ()
{
    NSUInteger _hash;
}

@end

@implementation RMMeshTriangle3D



- (instancetype)initWithVertexA:(RMMeshVertex3D*)a b:(RMMeshVertex3D*)b c:(RMMeshVertex3D*)c
{
    self = [super init];
    if (self)
    {
        _a = a;
        _b = b;
        _c = c;
        
        _hash = [self _hash];
    }
    return self;
}

+ (nonnull instancetype)triangleWithVertexA:(RMMeshVertex3D*)a b:(RMMeshVertex3D*)b c:(RMMeshVertex3D*)c
{
    return [[[self class] alloc] initWithVertexA:a b:b c:c];
}

- (NSUInteger)hash
{
    return _hash;
}

- (NSUInteger)_hash
{
    const NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [self.a hash];
    result = prime * result + [self.b hash];
    result = prime * result + [self.c hash];
    return result;
}


- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    else if ([self class] == [object class])
    {
        return [self isEqualToTriangle:object];
    }
    return NO;
}

- (BOOL)isEqualToTriangle:(RMMeshTriangle3D*)triangle
{
    if (self == triangle)
    {
        return YES;
    }
    
    if (triangle == nil)
    {
        return NO;
    }
    
    if ([self hash] != [triangle hash])
    {
        return NO;
    }
    
    return (
            (self.a == triangle.a || [self.a isEqualToVertex:triangle.a]) &&
            (self.b == triangle.b || [self.b isEqualToVertex:triangle.b]) &&
            (self.c == triangle.c || [self.c isEqualToVertex:triangle.c])
            );
}


@end
