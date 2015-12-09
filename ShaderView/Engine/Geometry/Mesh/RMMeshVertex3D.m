//
//  RMVertex3D.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/4/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMeshVertex3D.h"

#import "RMVector.h"


@interface RMMeshVertex3D ()
{
    NSUInteger _hash;
}

@end



@implementation RMMeshVertex3D

- (instancetype)init
{
    return [self initWithPosition:nil normal:nil color:nil uv0:nil uv1:nil uv2:nil uv3:nil];
}

- (nonnull instancetype)initWithPosition:(nullable RMVector3*)position
                                  normal:(nullable RMVector3*)normal
                                   color:(nullable RMVector4*)color
                                     uv0:(nullable RMVector2*)uv0
                                     uv1:(nullable RMVector2*)uv1
                                     uv2:(nullable RMVector2*)uv2
                                     uv3:(nullable RMVector2*)uv3
{
    self = [super init];
    if (self)
    {
        _position = position;
        _normal = normal;
        _color = color;
        _uv0 = uv0;
        _uv1 = uv1;
        _uv2 = uv2;
        _uv3 = uv3;
    }
    return self;
}


- (instancetype)initWithPosition:(RMVector3*)position
                          normal:(RMVector3*)normal
                             uv0:(RMVector2*)uv0
{
    return [self initWithPosition:position normal:normal color:nil uv0:uv0 uv1:nil uv2:nil uv3:nil];
}


- (instancetype)initWithPosition:(RMVector3*)position
                             uv0:(RMVector2*)uv0
{
    return [self initWithPosition:position normal:nil color:nil uv0:uv0 uv1:nil uv2:nil uv3:nil];
}


+ (instancetype)vertexWithPosition:(RMVector3*)position
                            normal:(RMVector3*)normal
                             color:(RMVector4*)color
                               uv0:(RMVector2*)uv0
                               uv1:(RMVector2*)uv1
                               uv2:(RMVector2*)uv2
                               uv3:(RMVector2*)uv3
{
    return [[[self class] alloc] initWithPosition:position normal:normal color:color uv0:uv0 uv1:uv1 uv2:uv2 uv3:uv3];
}

+ (instancetype)vertexWithPosition:(RMVector3*)position
                            normal:(RMVector3*)normal
                               uv0:(RMVector2*)uv0
{
    return [[[self class] alloc] initWithPosition:position normal:normal uv0:uv0];
}


+ (instancetype)vertexWithPosition:(RMVector3*)position
                               uv0:(RMVector2*)uv0
{
    return [[[self class] alloc] initWithPosition:position uv0:uv0];
}


- (NSUInteger)hash
{
    if (_hash == 0)
    {
        const NSUInteger prime = 31;

        _hash = prime + [self.position hash];
        _hash = prime * _hash + [self.normal hash];
        _hash = prime * _hash + [self.color hash];
        _hash = prime * _hash + [self.uv0 hash];
        _hash = prime * _hash + [self.uv1 hash];
        _hash = prime * _hash + [self.uv2 hash];
        _hash = prime * _hash + [self.uv3 hash];
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
        return [self isEqualToVertex:object];
    }
    return NO;
}

- (BOOL)isEqualToVertex:(RMMeshVertex3D*)vertex
{
    if (self == vertex)
    {
        return YES;
    }
    
    if (vertex == nil)
    {
        return NO;
    }
    
    if ([self hash] != [vertex hash])
    {
        return NO;
    }
    
    return (
            (self.position == vertex.position || [self.position isEqualToVector3:vertex.position])
            && (self.uv0 == vertex.uv0 || [self.uv0 isEqualToVector2:vertex.uv0])
            && (self.normal == vertex.normal || [self.normal isEqualToVector3:vertex.normal])
            && (self.color == vertex.color || [self.color isEqualToVector4:vertex.color])
            && (self.uv1 == vertex.uv1 || [self.uv1 isEqualToVector2:vertex.uv1])
            && (self.uv2 == vertex.uv2 || [self.uv2 isEqualToVector2:vertex.uv2])
            && (self.uv3 == vertex.uv3 || [self.uv3 isEqualToVector2:vertex.uv3])
            );
    
}

#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}


@end
