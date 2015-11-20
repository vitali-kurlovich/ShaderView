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

@class RMMatrix;

@interface RMCamera : NSObject
- (nullable RMMatrix*)matrix;
@end

@interface RMCamera3D : RMCamera
@property (nonatomic) float near;
@property (nonatomic) float far;

@property (nonatomic) float left;
@property (nonatomic) float right;

@property (nonatomic) float bottom;
@property (nonatomic) float top;

- (nonnull instancetype)initWithLeft:(float)left right:(float)right top:(float)top bottom:(float)bottom near:(float)near far:(float)far;

+ (nonnull instancetype)cameraWithLeft:(float)left right:(float)right top:(float)top bottom:(float)bottom near:(float)near far:(float)far;

@end