//
//  RMMathMatrix.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/5/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    float m00, m01, m02, m03;
    float m10, m11, m12, m13;
    float m20, m21, m22, m23;
    float m30, m31, m32, m33;
} _RMMatrix4x4;



extern _RMMatrix4x4 const kRMIdentityMatrix4x4;



_RMMatrix4x4 RMMulMatrix4x4(_RMMatrix4x4 const a, _RMMatrix4x4 const b);
_RMMatrix4x4 RMMulMatrix4x4ToScalar(_RMMatrix4x4 const a, float scalar);

_RMMatrix4x4 RMTranslateMatrix4x4(float x, float y, float z);
_RMMatrix4x4 RMScaleMatrix4x4(float sx, float sy, float sz);
_RMMatrix4x4 RMRotateMatrix4x4( float alpha, float x, float y, float z);

_RMMatrix4x4 RMTransposeMatrix4x4(_RMMatrix4x4 const a);

float RMDetMatrix4x4(_RMMatrix4x4 const a);
_RMMatrix4x4 RMInverseMatrix4x4(_RMMatrix4x4 const a, BOOL *sucess);

BOOL isRMMatrix4x4Equal(_RMMatrix4x4 const a, _RMMatrix4x4 const b);
