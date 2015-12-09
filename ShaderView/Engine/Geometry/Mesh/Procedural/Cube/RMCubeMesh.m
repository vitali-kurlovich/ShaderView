//
//  RMCubeMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMCubeMesh.h"

#import "RMMeshBuilder.h"

#import "RMMeshQuad3D.h"
#import "RMMeshTriangle3D.h"
#import "RMMeshVertex3D.h"
#import "RMVector.h"

@interface RMCubeMesh()

@end

@implementation RMCubeMesh

- (void)build:(RMMeshBuilder*)builder
{
    RMVector3* a = [RMVector3 vectorWithX:-0.5 y:-0.5 z:0.5];
    RMVector3* b = [RMVector3 vectorWithX: 0.5 y:-0.5 z:0.5];
    RMVector3* c = [RMVector3 vectorWithX: 0.5 y: 0.5 z:0.5];
    RMVector3* d = [RMVector3 vectorWithX:-0.5 y: 0.5 z:0.5];
    
    RMVector2* uv00 = [RMVector2 vectorWithX:0 y:0];
    RMVector2* uv01 = [RMVector2 vectorWithX:0 y:1];
    RMVector2* uv10 = [RMVector2 vectorWithX:1 y:0];
    RMVector2* uv11 = [RMVector2 vectorWithX:1 y:1];
    
    RMMeshVertex3D* va = [RMMeshVertex3D vertexWithPosition:a uv0:uv01];
    RMMeshVertex3D* vb = [RMMeshVertex3D vertexWithPosition:b uv0:uv11];
    RMMeshVertex3D* vc = [RMMeshVertex3D vertexWithPosition:c uv0:uv10];
    RMMeshVertex3D* vd = [RMMeshVertex3D vertexWithPosition:d uv0:uv00];
    
    
    [builder appendQuadWithVertexA:va b:vb c:vc d:vd];
    
    
    RMVector3* as = [RMVector3 vectorWithX: 0.5 y:-0.5 z:-0.5];
    RMVector3* bs = [RMVector3 vectorWithX:-0.5 y:-0.5 z:-0.5];
    RMVector3* cs = [RMVector3 vectorWithX:-0.5 y: 0.5 z:-0.5];
    RMVector3* ds = [RMVector3 vectorWithX: 0.5 y: 0.5 z:-0.5];
   
    va = [RMMeshVertex3D vertexWithPosition:b uv0:uv01];
    vb = [RMMeshVertex3D vertexWithPosition:as uv0:uv11];
    vc = [RMMeshVertex3D vertexWithPosition:ds uv0:uv10];
    vd = [RMMeshVertex3D vertexWithPosition:c uv0:uv00];
    
    [builder appendQuadWithVertexA:va b:vb c:vc d:vd];
    
    
    va = [RMMeshVertex3D vertexWithPosition:as uv0:uv01];
    vb = [RMMeshVertex3D vertexWithPosition:bs uv0:uv11];
    vc = [RMMeshVertex3D vertexWithPosition:cs uv0:uv10];
    vd = [RMMeshVertex3D vertexWithPosition:ds uv0:uv00];
    
    [builder appendQuadWithVertexA:va b:vb c:vc d:vd];
    
    va = [RMMeshVertex3D vertexWithPosition:bs uv0:uv01];
    vb = [RMMeshVertex3D vertexWithPosition:a uv0:uv11];
    vc = [RMMeshVertex3D vertexWithPosition:d uv0:uv10];
    vd = [RMMeshVertex3D vertexWithPosition:cs uv0:uv00];
    
    [builder appendQuadWithVertexA:va b:vb c:vc d:vd];
    
    
    va = [RMMeshVertex3D vertexWithPosition:bs uv0:uv01];
    vb = [RMMeshVertex3D vertexWithPosition:as uv0:uv11];
    vc = [RMMeshVertex3D vertexWithPosition:b uv0:uv10];
    vd = [RMMeshVertex3D vertexWithPosition:a uv0:uv00];
    
    [builder appendQuadWithVertexA:va b:vb c:vc d:vd];
    
    va = [RMMeshVertex3D vertexWithPosition:ds uv0:uv01];
    vb = [RMMeshVertex3D vertexWithPosition:cs uv0:uv11];
    vc = [RMMeshVertex3D vertexWithPosition:d uv0:uv10];
    vd = [RMMeshVertex3D vertexWithPosition:c uv0:uv00];
    
    [builder appendQuadWithVertexA:va b:vb c:vc d:vd];
    
}

@end
