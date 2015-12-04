//
//  MRQuad3D.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMVector3;

@interface RMQuad3D : NSObject
@property (nonnull, nonatomic, readonly) RMVector3* a;
@property (nonnull, nonatomic, readonly) RMVector3* b;
@property (nonnull, nonatomic, readonly) RMVector3* c;
@property (nonnull, nonatomic, readonly) RMVector3* d;

- (nonnull instancetype)initWithPointA:(nonnull RMVector3*)a b:(nonnull RMVector3*)b c:(nonnull RMVector3*)c d:(nonnull RMVector3*)d;

+ (nonnull instancetype)quadWithPointA:(nonnull RMVector3*)a b:(nonnull RMVector3*)b c:(nonnull RMVector3*)c d:(nonnull RMVector3*)d;

- (BOOL)isEqualToQuad3D:(nonnull RMQuad3D*)quad;

@end
