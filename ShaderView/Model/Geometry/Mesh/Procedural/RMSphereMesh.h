//
//  RMSphereMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/5/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMProceduralMesh.h"

@interface RMSphereMesh : RMProceduralMesh
@property (nonatomic) NSUInteger segments;
@property (nonatomic) NSUInteger rings;
@property (nonatomic) float radius;

@property (nonatomic) BOOL smoothNormals;

@end
