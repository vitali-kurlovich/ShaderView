//
//  RMCamera.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMMath.h"

_RMMatrix4x4 RMPerspectiveFrustumMatrix4x4(float left, float right, float top, float bottom, float near, float far);


@interface RMCamera : NSObject

@end
