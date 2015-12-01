//
//  RMMath.h
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/19/15.
//
//

#import <Foundation/Foundation.h>

typedef struct {
    float m00, m01, m02, m03;
    float m10, m11, m12, m13;
    float m20, m21, m22, m23;
    float m30, m31, m32, m33;
} _RMMatrix4x4;

typedef struct {
    float x,y;
} _RMVector2;

typedef struct {
    float x,y,z;
} _RMVector3;

typedef struct {
    float x,y,z,w;
} _RMVector4;



extern _RMMatrix4x4 const kRMIdentityMatrix4x4;

extern _RMVector2 const kRMVector2Zero;
extern _RMVector3 const kRMVector3Zero;


inline float RMDotVector2(_RMVector2 a, _RMVector2 b)
{
    return a.x*b.x + a.y*b.y;
}

inline float RMDotVector3(_RMVector3 a, _RMVector3 b)
{
    return a.x*b.x + a.y*b.y + a.z*b.z;
}



_RMMatrix4x4 RMMulMatrix4x4(_RMMatrix4x4 const a, _RMMatrix4x4 const b);
_RMMatrix4x4 RMMulMatrix4x4ToScalar(_RMMatrix4x4 const a, float scalar);

_RMMatrix4x4 RMTranslateMatrix4x4(float x, float y, float z);
_RMMatrix4x4 RMScaleMatrix4x4(float sx, float sy, float sz);
_RMMatrix4x4 RMRotateMatrix4x4( float alpha, float x, float y, float z);

_RMMatrix4x4 RMTransposeMatrix4x4(_RMMatrix4x4 const a);

float RMDetMatrix4x4(_RMMatrix4x4 const a);
_RMMatrix4x4 RMInverseMatrix4x4(_RMMatrix4x4 const a, BOOL *sucess);

BOOL isRMMatrix4x4Equal(_RMMatrix4x4 const a, _RMMatrix4x4 const b);



@interface RMMath : NSObject

@end
