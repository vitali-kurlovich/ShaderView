//
//  RMTransform.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/23/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTransform.h"

@implementation RMTransform

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




@end
