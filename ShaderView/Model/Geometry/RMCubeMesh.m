//
//  RMCubeMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMCubeMesh.h"

#import "RMMeshBuilder.h"

#import "RMQuad3D.h"
#import "RMTriangle3D.h"
#import "RMVector.h"

@interface RMCubeMesh()

@end

@implementation RMCubeMesh

- (void)build:(RMMeshBuilder*)builder
{
    RMVector3* a = [RMVector3 vectorWithX:-0.5 y:-0.5 z:0.5];
    RMVector3* b = [RMVector3 vectorWithX:-0.5 y: 0.5 z:0.5];
    RMVector3* c = [RMVector3 vectorWithX: 0.5 y: 0.5 z:0.5];
    RMVector3* d = [RMVector3 vectorWithX: 0.5 y:-0.5 z:0.5];
    
    RMVector3* a1 = [RMVector3 vectorWithX:-0.5 y:-0.5 z:-0.5];
    RMVector3* b1 = [RMVector3 vectorWithX:-0.5 y: 0.5 z:-0.5];
    RMVector3* c1 = [RMVector3 vectorWithX: 0.5 y: 0.5 z:-0.5];
    RMVector3* d1 = [RMVector3 vectorWithX: 0.5 y:-0.5 z:-0.5];
    
    

   [builder appendQuad:[RMQuad3D quadWithPointA:a b:b c:c d:d]];
   [builder appendQuad:[RMQuad3D quadWithPointA:d b:c c:c1 d:d1]];
   [builder appendQuad:[RMQuad3D quadWithPointA:d1 b:c1 c:b1 d:a1]];
   [builder appendQuad:[RMQuad3D quadWithPointA:a1 b:b1 c:b d:a]];
}

@end
