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

extern _RMMatrix4x4 const kRMIdentityMatrix4x4;

_RMMatrix4x4 RMMulMatrix4x4(_RMMatrix4x4 const a, _RMMatrix4x4 const b);
BOOL isRMMatrix4x4Equal(_RMMatrix4x4 const a, _RMMatrix4x4 const b);

@interface RMMath : NSObject

@end
