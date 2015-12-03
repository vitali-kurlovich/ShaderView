//
//  RMProceduralMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMesh.h"

@class RMMeshBuilder;

@interface RMProceduralMesh : RMMesh

- (void)build:(nonnull RMMeshBuilder*)builder;

- (void)setNeedsRebuild;
@end
