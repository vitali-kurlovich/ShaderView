//
//  MRQuad3D.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMQuad3D.h"

#import "RMVector.h"

@implementation RMQuad3D

- (instancetype)initWithPointA:(RMVector3*)a b:(RMVector3*)b c:(RMVector3*)c d:(RMVector3*)d
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

+ (instancetype)quadWithPointA:(RMVector3*)a b:(RMVector3*)b c:(RMVector3*)c d:(RMVector3*)d
{
    return [[[self class] alloc] initWithPointA:a b:b c:c d:d];
}

- (NSUInteger)hash
{
    const NSUInteger prime = 31;
    NSUInteger result = 1;
    result = prime * result + [self.a hash];
    result = prime * result + [self.b hash];
    result = prime * result + [self.c hash];
    result = prime * result + [self.d hash];
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
        return [self isEqualToQuad3D:object];
    }
    return NO;
}

- (BOOL)isEqualToQuad3D:(RMQuad3D*)quad
{
    return self == quad || ([self.a isEqualToVector3:quad.a] && [self.b isEqualToVector3:quad.b] && [self.c isEqualToVector3:quad.c] && [self.d isEqualToVector3:quad.d]);
}

@end
