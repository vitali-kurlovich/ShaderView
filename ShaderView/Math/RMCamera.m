//
//  RMCamera.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMCamera.h"

#import "RMMatrix4x4.h"

_RMMatrix4x4 RMPerspectiveFrustumMatrix4x4(float left, float right, float top, float bottom, float near, float far)
{
    _RMMatrix4x4 p =
    {
        2*near/(right-left),       0,                           0,                          0,
        0,                         2*near/(top-bottom),         0,                          0,
        (left+right)/(right-left), (bottom + top)/(top-bottom), (-far - near)/(far - near), -1,
        0,                         0,                           -2*far*near/(far - near),   0
    };
    
    return p;
}



@implementation RMCamera
- (RMMatrix*)matrix
{
    return nil;
}
@end


@implementation RMCamera3D

- (RMMatrix4x4*)matrix
{
    return [[RMMatrix4x4 alloc] initWithMatrix:RMPerspectiveFrustumMatrix4x4(self.left, self.right, self.top, self.bottom, self.near, self.far)];
}


- (nonnull instancetype)initWithLeft:(float)left right:(float)right top:(float)top bottom:(float)bottom near:(float)near far:(float)far
{
    self = [super init];
    if (self)
    {
        _left = left;
        _right = right;
        _top = top;
        _bottom = bottom;
        
        _near = near;
        _far = far;
    }
    
    return self;
}


+ (nonnull instancetype)cameraWithLeft:(float)left right:(float)right top:(float)top bottom:(float)bottom near:(float)near far:(float)far
{
    return [[[self class] alloc] initWithLeft:left right:right top:top bottom:bottom near:near far:far];
}

@end