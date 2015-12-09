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

@interface RMMatrix : NSObject<NSCopying>

@property (nonatomic, readonly) RMMatrixType type;

- (nullable instancetype)initWithType:(RMMatrixType)type NS_DESIGNATED_INITIALIZER;

+ (nullable instancetype)matrix;

+ (nullable instancetype)translateMatrixWithX:(float)x y:(float)y;
+ (nullable instancetype)translateMatrixWithX:(float)x y:(float)y z:(float)z;

+ (nullable instancetype)scaleMatrixWithX:(float)x y:(float)y;
+ (nullable instancetype)scaleMatrixWithX:(float)x y:(float)y z:(float)z;

+ (nullable instancetype)rotateMatrixWithAngle:(float)angle;
+ (nullable instancetype)rotateMatrixWithAngle:(float)angle x:(float)x y:(float)y z:(float)z;


- (nullable instancetype)mul:(nullable RMMatrix*)matrix;

@end




