//
//  RMVector.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMMath.h"

typedef NS_ENUM(NSInteger, RMVectorType) {
    RMVectorTypeNone = 0,
    RMVectorType2,
    RMVectorType3,
    RMVectorType4
};

@interface RMVector : NSObject
@property (nonatomic, readonly) RMVectorType type;

- (nullable instancetype)initWithType:(RMVectorType)type NS_DESIGNATED_INITIALIZER;

@end


@interface RMVector2 : RMVector
@property (nonatomic, readonly) _RMVector2 vector;

- (nonnull instancetype)initWithX:(float)x y:(float)y;

+ (nonnull instancetype)vectorWithX:(float)x y:(float)y;
+ (nonnull instancetype)vectorWithRMVector:(_RMVector2)vector;

@end



@interface RMVector3 : RMVector
@property (nonatomic, readonly) _RMVector3 vector;

- (nonnull instancetype)initWithX:(float)x y:(float)y z:(float)z;
- (nonnull instancetype)initWithX:(float)x y:(float)y;



+ (nonnull instancetype)vectorWithX:(float)x y:(float)y z:(float)z;
+ (nonnull instancetype)vectorWithX:(float)x y:(float)y;

+ (nonnull instancetype)vectorWithRMVector:(_RMVector3)vector;

@end
