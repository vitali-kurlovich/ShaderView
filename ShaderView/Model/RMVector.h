//
//  RMVector.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, RMVectorType) {
    RMVectorTypeNone = 0,
    RMVectorType2,
    RMVectorType3,
    RMVectorType4
};

@interface RMVector : NSObject
@property (nonatomic, readonly) RMVectorType type;

- (nullable instancetype)initWithType:(RMVectorType)type NS_DESIGNATED_INITIALIZER;
+ (nullable instancetype)vector;

@end
