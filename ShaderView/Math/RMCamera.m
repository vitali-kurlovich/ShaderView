//
//  RMCamera.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMCamera.h"


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

@end
