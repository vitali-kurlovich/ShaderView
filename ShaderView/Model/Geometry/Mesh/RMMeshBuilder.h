//
//  RMMeshBuilder.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/2/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import Foundation;

#import "RMVBOVertexAttribute.h"

@class RMMesh;
@class RMMeshTriangle3D, RMMeshQuad3D;

@interface RMMeshBuilder : NSObject

@property (nonatomic, readonly) RMVBOVertexAttributeType format;
@property (nonnull, nonatomic, readonly) NSArray<RMVBOVertexAttribute*>* attributes;

- (nonnull RMMesh*)build;
- (void)reset;
- (void)appendTriangle:(nonnull RMMeshTriangle3D*)triangle;
- (void)appendQuad:(nonnull RMMeshQuad3D*)quad;


- (nonnull instancetype)initWithFormat:(RMVBOVertexAttributeType)format NS_DESIGNATED_INITIALIZER;

@end