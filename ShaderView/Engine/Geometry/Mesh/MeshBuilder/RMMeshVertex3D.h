//
//  RMVertex3D.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/4/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMVector4, RMVector3, RMVector2;

@interface RMMeshVertex3D : NSObject<NSCopying>

@property (nullable, nonatomic, readonly) RMVector3* position;
@property (nullable, nonatomic, readonly) RMVector3* normal;

@property (nullable, nonatomic, readonly) RMVector4* color;

@property (nullable, nonatomic, readonly) RMVector2* uv0;
@property (nullable, nonatomic, readonly) RMVector2* uv1;
@property (nullable, nonatomic, readonly) RMVector2* uv2;
@property (nullable, nonatomic, readonly) RMVector2* uv3;

- (nonnull instancetype)initWithPosition:(nullable RMVector3*)position
                                  normal:(nullable RMVector3*)normal
                                   color:(nullable RMVector4*)color
                                     uv0:(nullable RMVector2*)uv0
                                     uv1:(nullable RMVector2*)uv1
                                     uv2:(nullable RMVector2*)uv2
                                     uv3:(nullable RMVector2*)uv3
NS_DESIGNATED_INITIALIZER;


- (nonnull instancetype)initWithPosition:(nullable RMVector3*)position
                                  normal:(nullable RMVector3*)normal
                                     uv0:(nullable RMVector2*)uv0;

- (nonnull instancetype)initWithPosition:(nullable RMVector3*)position
                                     uv0:(nullable RMVector2*)uv0;


+ (nonnull instancetype)vertexWithPosition:(nullable RMVector3*)position
                                    normal:(nullable RMVector3*)normal
                                     color:(nullable RMVector4*)color
                                       uv0:(nullable RMVector2*)uv0
                                       uv1:(nullable RMVector2*)uv1
                                       uv2:(nullable RMVector2*)uv2
                                       uv3:(nullable RMVector2*)uv3;

+ (nonnull instancetype)vertexWithPosition:(nullable RMVector3*)position
                                    normal:(nullable RMVector3*)normal
                                       uv0:(nullable RMVector2*)uv0;

+ (nonnull instancetype)vertexWithPosition:(nullable RMVector3*)position
                                       uv0:(nullable RMVector2*)uv0;


- (BOOL)isEqualToVertex:(nonnull RMMeshVertex3D*)vertex;

@end
