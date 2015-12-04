//
//  MRTriangle.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTriangle3D.h"

#import "RMVector.h"

@implementation RMTriangle3D

- (instancetype)initWithPointA:(RMVector3*)a b:(RMVector3*)b c:(RMVector3*)c
{
    self = [super init];
    if (self)
    {
        _a = a;
        _b = b;
        _c = c;
    }
    return self;
}

+ (nonnull instancetype)triangleWithPointA:(nonnull RMVector3*)a b:(nonnull RMVector3*)b c:(nonnull RMVector3*)c
{
   return [[[self class] alloc] initWithPointA:a b:b c:c];
}

- (NSUInteger)hash
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
        return [self isEqualToTriangle3D:object];
    }
    return NO;
}

- (BOOL)isEqualToTriangle3D:(RMTriangle3D*)triangle
{
    return self == triangle || ([self.a isEqualToVector3:triangle.a] && [self.b isEqualToVector3:triangle.b] && [self.c isEqualToVector3:triangle.c]);
}


@end
