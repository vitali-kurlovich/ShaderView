//
//  RMTorusMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/6/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMProceduralMesh.h"

@interface RMTorusMesh : RMProceduralMesh

@property (nonatomic) NSUInteger segments;
@property (nonatomic) NSUInteger rings;
@property (nonatomic) float minorRadius;
@property (nonatomic) float majorRadius;



@end
