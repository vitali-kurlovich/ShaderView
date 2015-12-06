//
//  RMQuadTriangle3D.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/4/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMeshQuad3D.h"

#import "RMMeshVertex3D.h"


@interface RMMeshQuad3D ()
{
    NSUInteger _hash;
}

@end

@implementation RMMeshQuad3D


- (instancetype)initWithVertexA:(RMMeshVertex3D*)a b:(RMMeshVertex3D*)b c:(RMMeshVertex3D*)c d:(RMMeshVertex3D*)d
{
    self = [super init];
    if (self)
    {
        _a = a;
        _b = b;
        _c = c;
        _d = d;
    }
    return self;
}

+ (instancetype)quadWithVertexA:(RMMeshVertex3D*)a b:(RMMeshVertex3D*)b c:(RMMeshVertex3D*)c d:(RMMeshVertex3D*)d
{
    return [[[self class] alloc] initWithVertexA:a b:b c:c d:d];
}


- (NSUInteger)hash
{
    if (_hash == 0)
    {
        const NSUInteger prime = 31;
        _hash = 1;
        _hash = prime * _hash + [self.a hash];
        _hash = prime * _hash + [self.b hash];
        _hash = prime * _hash + [self.c hash];
        _hash = prime * _hash + [self.d hash];
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
        return [self isEqualToQuad:object];
    }
    return NO;
}

- (BOOL)isEqualToQuad:(RMMeshQuad3D*)quad
{
    if (self == quad)
    {
        return YES;
    }
    
    if (quad == nil)
    {
        return NO;
    }
    
    if ([self hash] != [quad hash])
    {
        return NO;
    }
    
    return (
            (self.a == quad.a || [self.a isEqualToVertex:quad.a]) &&
            (self.b == quad.b || [self.b isEqualToVertex:quad.b]) &&
            (self.c == quad.c || [self.c isEqualToVertex:quad.c]) &&
            (self.d == quad.d || [self.d isEqualToVertex:quad.d])
            );
}


@end
