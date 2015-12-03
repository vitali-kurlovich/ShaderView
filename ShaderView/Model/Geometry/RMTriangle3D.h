//
//  MRTriangle.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMVector3;

@interface RMTriangle3D : NSObject
@property (nonnull, nonatomic, readonly) RMVector3* a;
@property (nonnull, nonatomic, readonly) RMVector3* b;
@property (nonnull, nonatomic, readonly) RMVector3* c;

- (nonnull instancetype)initWithPointA:(nonnull RMVector3*)a b:(nonnull RMVector3*)b c:(nonnull RMVector3*)c;

+ (nonnull instancetype)triangleWithPointA:(nonnull RMVector3*)a b:(nonnull RMVector3*)b c:(nonnull RMVector3*)c;

- (BOOL)isEqualToTriangle3D:(nonnull RMTriangle3D*)triangle;

@end
