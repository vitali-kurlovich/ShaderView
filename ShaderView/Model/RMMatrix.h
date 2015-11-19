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

@property (nullable, nonatomic, readonly) const float* mat;
@property (nonatomic, readonly) RMMatrixType type;

- (nullable instancetype)initWithType:(RMMatrixType)type NS_DESIGNATED_INITIALIZER;

+ (nullable instancetype)matrix;

@end


@interface RMMatrix2x2 : RMMatrix

@end

@interface RMMutableMatrix2x2 : RMMatrix2x2


@end


@interface RMMatrix3x3 : RMMatrix

@end

@interface RMMatrix4x4 : RMMatrix

@end