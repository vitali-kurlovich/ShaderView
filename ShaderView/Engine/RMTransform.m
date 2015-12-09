//
//  RMTransform.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/23/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTransform.h"

@implementation RMTransform

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _sx = _sy = _sz = 1;
    }
    return self;
}

- (void)setNeedsUpdate
{
    _matrix = nil;
}

- (void)setX:(float)x
{
    if (_x != x)
    {
        _x = x;
        [self setNeedsUpdate];
    }
}

- (void)setY:(float)y
{
    if (_y != y)
    {
        _y = y;
        [self setNeedsUpdate];
    }
}


- (void)setZ:(float)z
{
    if (_z != z)
    {
        _z = z;
        [self setNeedsUpdate];
    }
}

- (void)setRx:(float)rx
{
    if (_rx != rx)
    {
        _rx = rx;
        [self setNeedsUpdate];
    }
}

- (void)setRy:(float)ry
{
    if (_ry != ry)
    {
        _ry = ry;
        [self setNeedsUpdate];
    }
}


- (void)setRz:(float)rz
{
    if (_rz != rz)
    {
        _rz = rz;
        [self setNeedsUpdate];
    }
}



- (void)setSx:(float)sx
{
    if (_sx != sx)
    {
        _sx = sx;
        [self setNeedsUpdate];
    }
}


- (void)setSy:(float)sy
{
    if (_sy != sy)
    {
        _sy = sy;
        [self setNeedsUpdate];
    }
}

- (void)setSz:(float)sz
{
    if (_sz != sz)
    {
        _sz = sz;
        [self setNeedsUpdate];
    }
}

@end
