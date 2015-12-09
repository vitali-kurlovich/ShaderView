//
//  RMQuadTriangle3D.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/4/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMMeshVertex3D;

@interface RMMeshQuad3D : NSObject
@property (nonnull, nonatomic, readonly) RMMeshVertex3D* a;
@property (nonnull, nonatomic, readonly) RMMeshVertex3D* b;
@property (nonnull, nonatomic, readonly) RMMeshVertex3D* c;
@property (nonnull, nonatomic, readonly) RMMeshVertex3D* d;

- (nonnull instancetype)initWithVertexA:(nonnull RMMeshVertex3D*)a b:(nonnull RMMeshVertex3D*)b c:(nonnull RMMeshVertex3D*)c d:(nonnull RMMeshVertex3D*)d;

+ (nonnull instancetype)quadWithVertexA:(nonnull RMMeshVertex3D*)a b:(nonnull RMMeshVertex3D*)b c:(nonnull RMMeshVertex3D*)c d:(nonnull RMMeshVertex3D*)d;

- (BOOL)isEqualToQuad:(nonnull RMMeshQuad3D*)quad;
@end
