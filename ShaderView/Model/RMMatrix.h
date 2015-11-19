//
//  RMMatrix.h
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

@import Foundation;




typedef NS_ENUM(NSInteger, RMMatrixType) {
    RMMatrixTypeNone = 0,
    RMMatrixType2x2,
    RMMatrixType3x3,
    RMMatrixType4x4
};

@interface RMMatrix : NSObject<NSCopying, NSMutableCopying>

@property (nullable, nonatomic, readonly) const float* matrix;
@property (nonatomic, readonly) RMMatrixType type;

@property (nonatomic) float m00;
@property (nonatomic) float m01;
@property (nonatomic) float m02;
@property (nonatomic) float m03;

@property (nonatomic) float m10;
@property (nonatomic) float m11;
@property (nonatomic) float m12;
@property (nonatomic) float m13;

@property (nonatomic) float m20;
@property (nonatomic) float m21;
@property (nonatomic) float m22;
@property (nonatomic) float m23;

@property (nonatomic) float m30;
@property (nonatomic) float m31;
@property (nonatomic) float m32;
@property (nonatomic) float m33;


- (nullable instancetype)initWithType:(RMMatrixType)type NS_DESIGNATED_INITIALIZER;

+ (nullable instancetype)matrix;

@end





@interface RMMatrix4x4 : RMMatrix

@end