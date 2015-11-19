//
//  RMMath.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/19/15.
//
//

#import "RMMath.h"


_RMMatrix4x4 const kRMIdentityMatrix4x4 =
{
    1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1
};



_RMMatrix4x4 RMMulMatrix4x4(_RMMatrix4x4 const a, _RMMatrix4x4 const b)
{
    _RMMatrix4x4 c;
    
    c.m00 = a.m00*b.m00 + a.m01*b.m10 + a.m02*b.m20 + a.m03*b.m30;
    c.m01 = a.m00*b.m01 + a.m01*b.m11 + a.m02*b.m21 + a.m03*b.m31;
    c.m02 = a.m00*b.m02 + a.m01*b.m12 + a.m02*b.m22 + a.m03*b.m32;
    c.m03 = a.m00*b.m03 + a.m01*b.m13 + a.m02*b.m23 + a.m03*b.m33;
    c.m10 = a.m10*b.m00 + a.m11*b.m10 + a.m12*b.m20 + a.m13*b.m30;
    c.m11 = a.m10*b.m01 + a.m11*b.m11 + a.m12*b.m21 + a.m13*b.m31;
    c.m12 = a.m10*b.m02 + a.m11*b.m12 + a.m12*b.m22 + a.m13*b.m32;
    c.m13 = a.m10*b.m03 + a.m11*b.m13 + a.m12*b.m23 + a.m13*b.m33;
    c.m20 = a.m20*b.m00 + a.m21*b.m10 + a.m22*b.m20 + a.m23*b.m30;
    c.m21 = a.m20*b.m01 + a.m21*b.m11 + a.m22*b.m21 + a.m23*b.m31;
    c.m22 = a.m20*b.m02 + a.m21*b.m12 + a.m22*b.m22 + a.m23*b.m32;
    c.m23 = a.m20*b.m03 + a.m21*b.m13 + a.m22*b.m23 + a.m23*b.m33;
    c.m30 = a.m30*b.m00 + a.m31*b.m10 + a.m32*b.m20 + a.m33*b.m30;
    c.m31 = a.m30*b.m01 + a.m31*b.m11 + a.m32*b.m21 + a.m33*b.m31;
    c.m32 = a.m30*b.m02 + a.m31*b.m12 + a.m32*b.m22 + a.m33*b.m32;
    c.m33 = a.m30*b.m03 + a.m31*b.m13 + a.m32*b.m23 + a.m33*b.m33;
    
    return c;
}

_RMMatrix4x4 RMMulMatrix4x4ToScalar(_RMMatrix4x4 const a, float scalar)
{
    _RMMatrix4x4 c = a;
    
    c.m00 *= scalar;
    c.m01 *= scalar;
    c.m02 *= scalar;
    c.m03 *= scalar;
    
    c.m10 *= scalar;
    c.m11 *= scalar;
    c.m12 *= scalar;
    c.m13 *= scalar;
    
    c.m20 *= scalar;
    c.m21 *= scalar;
    c.m22 *= scalar;
    c.m23 *= scalar;
    
    c.m30 *= scalar;
    c.m31 *= scalar;
    c.m32 *= scalar;
    c.m33 *= scalar;
    
    return c;
}

BOOL isRMMatrix4x4Equal(_RMMatrix4x4 const a, _RMMatrix4x4 const b)
{
    return
    (a.m00 == b.m00 && a.m01 == b.m01 && a.m02 == b.m02 && a.m03 == b.m03) &&
    (a.m10 == b.m10 && a.m11 == b.m11 && a.m12 == b.m12 && a.m13 == b.m13) &&
    (a.m20 == b.m20 && a.m21 == b.m21 && a.m22 == b.m22 && a.m23 == b.m23) &&
    (a.m30 == b.m30 && a.m31 == b.m31 && a.m32 == b.m32 && a.m33 == b.m33);
    
}

_RMMatrix4x4 RMTranslateMatrix4x4(float x, float y, float z)
{
    _RMMatrix4x4 result = kRMIdentityMatrix4x4;
    result.m30 = x;
    result.m31 = y;
    result.m32 = z;
    return result;
}

_RMMatrix4x4 RMScaleMatrix4x4(float sx, float sy, float sz)
{
    _RMMatrix4x4 result = kRMIdentityMatrix4x4;
    result.m00 = sx;
    result.m11 = sy;
    result.m22 = sz;
    return result;
}

_RMMatrix4x4 RMTransposeMatrix4x4(_RMMatrix4x4 const a)
{
    _RMMatrix4x4 result = {
        a.m00, a.m10, a.m20, a.m30,
        a.m01, a.m11, a.m21, a.m31,
        a.m02, a.m12, a.m22, a.m32,
        a.m03, a.m13, a.m23, a.m33
    };

    return result;
}

float RMDetMatrix4x4(_RMMatrix4x4 const a)
{
    float m00m31 = a.m00*a.m31;
    float m01m30 = a.m01*a.m30;
    
    float det =
    m01m30*a.m13*a.m22 -
    m01m30*a.m12*a.m23 -
    m00m31*a.m13*a.m22 +
    m00m31*a.m12*a.m23 -
    a.m01*a.m13*a.m20*a.m32 +
    a.m00*a.m13*a.m21*a.m32 +
    a.m01*a.m10*a.m23*a.m32 -
    a.m00*a.m11*a.m23*a.m32 +
    
    a.m03*  (
             a.m12*a.m21*a.m30 -
             a.m11*a.m22*a.m30 -
             a.m12*a.m20*a.m31 +
             a.m10*a.m22*a.m31 +
             a.m11*a.m20*a.m32 -
             a.m10*a.m21*a.m32
             ) +
    
    a.m01*a.m12*a.m20*a.m33 -
    a.m00*a.m12*a.m21*a.m33 -
    a.m01*a.m10*a.m22*a.m33 +
    a.m00*a.m11*a.m22*a.m33 +
    a.m02*  (
             -a.m13*a.m21*a.m30 +
             a.m11*a.m23*a.m30 +
             a.m13*a.m20*a.m31 - 
             a.m10*a.m23*a.m31 - 
             a.m11*a.m20*a.m33 + 
             a.m10*a.m21*a.m33
             );
    
    return det;
}

_RMMatrix4x4 RMInverseMatrix4x4(_RMMatrix4x4 const a, BOOL *sucess)
{
    _RMMatrix4x4 r = a;
    
    float det = RMDetMatrix4x4(a);
    if (det != 0)
    {
        *sucess = YES;
        _RMMatrix4x4 t = RMTransposeMatrix4x4(a);
        r = RMMulMatrix4x4ToScalar(t, 1/det);
        
    } else {
        *sucess = NO;
    }
    
    return r;
}

_RMMatrix4x4 RMRotateMatrix4x4( float alpha, float x, float y, float z)
{
    float cos = cosf(alpha);
    float sin = sinf(alpha);
    _RMMatrix4x4 r =
    {
        x*x*(1-cos)+cos,   x*y*(1-cos)-z*sin, x*z*(1-cos)+y*sin, 0,
        x*y*(1-cos)+z*sin, y*y*(1-cos)+cos,   y*z*(1-cos)-x*sin, 0,
        x*z*(1-cos)-y*sin, y*z*(1-cos)+x*sin, z*z*(1-cos)+cos,   0,
        0,                 0,                   0,                1
    };
    
    
    return r;
}

@implementation RMMath

@end
