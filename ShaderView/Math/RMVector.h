//
//  RMVector.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMMathVector.h"


@interface RMVector2 : NSObject
@property (nonatomic, readonly) _RMVector2 vector;

- (nonnull instancetype)initWithX:(float)x y:(float)y;

+ (nonnull instancetype)vectorWithX:(float)x y:(float)y;
+ (nonnull instancetype)vectorWithRMVector:(_RMVector2)vector;

- (BOOL)isEqualToVector2:(nonnull RMVector2*)vec;

@end



@interface RMVector3 : NSObject
@property (nonatomic, readonly) _RMVector3 vector;

- (nonnull instancetype)initWithX:(float)x y:(float)y z:(float)z;
- (nonnull instancetype)initWithX:(float)x y:(float)y;

+ (nonnull instancetype)vectorWithX:(float)x y:(float)y z:(float)z;
+ (nonnull instancetype)vectorWithX:(float)x y:(float)y;

+ (nonnull instancetype)vectorWithRMVector:(_RMVector3)vector;

- (BOOL)isEqualToVector3:(nonnull RMVector3*)vec;

@end


@interface RMVector4 : NSObject
@property (nonatomic, readonly) _RMVector4 vector;

- (nonnull instancetype)initWithX:(float)x y:(float)y z:(float)z w:(float)w;

+ (nonnull instancetype)vectorWithRMVector:(_RMVector4)vector;
+ (nonnull instancetype)vectorWithX:(float)x y:(float)y z:(float)z w:(float)w;

- (BOOL)isEqualToVector4:(nonnull RMVector4*)vec;

@end