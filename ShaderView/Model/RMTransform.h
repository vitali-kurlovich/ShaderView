//
//  RMTransform.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/23/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMMatrix4x4;

@interface RMTransform : NSObject

@property (nonatomic, readonly) RMMatrix4x4* matrix;

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float z;

@property (nonatomic) float rx;
@property (nonatomic) float ry;
@property (nonatomic) float rz;

@property (nonatomic) float sx;
@property (nonatomic) float sy;
@property (nonatomic) float sz;


@end
