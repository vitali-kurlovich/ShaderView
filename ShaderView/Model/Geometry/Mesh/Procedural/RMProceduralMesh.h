//
//  RMProceduralMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMesh.h"

#import "RMVBOVertexAttribute.h"

@class RMMeshBuilder;

@interface RMProceduralMesh : RMMesh
@property (nonatomic, readonly) RMVBOVertexAttributeType format;
- (void)build:(nonnull RMMeshBuilder*)builder;

- (void)setNeedsRebuild;


- (nonnull instancetype)initWithFormat:(RMVBOVertexAttributeType)format NS_DESIGNATED_INITIALIZER;
@end
