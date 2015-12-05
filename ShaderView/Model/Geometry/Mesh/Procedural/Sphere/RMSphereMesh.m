//
//  RMSphereMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/5/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSphereMesh.h"

#import "RMMath.h"

#import "RMMeshBuilder.h"

#import "RMMeshQuad3D.h"
#import "RMMeshTriangle3D.h"
#import "RMMeshVertex3D.h"


@implementation RMSphereMesh

- (instancetype)initWithFormat:(RMVBOVertexAttributeType)format
{
    self = [super initWithFormat:format];
    if (self)
    {
        _rings = 25;
        _segments = 32;
        _radius = 1;
    }
    return self;
}

- (void)setSegments:(NSUInteger)segments
{
    if (_segments != segments)
    {
        _segments = segments;
        [self setNeedsRebuild];
    }
}

- (void)setRings:(NSUInteger)rings
{
    if (_rings != rings)
    {
        _rings = rings;
        [self setNeedsRebuild];
    }
}

- (void)setRadius:(float)radius
{
    if (_radius != radius)
    {
        _radius = radius;
        [self setNeedsRebuild];
    }
}


- (void)build:(RMMeshBuilder*)builder
{
    int vertCount = self.rings + 2;
    
    _RMVector3 normals[vertCount];
    _RMVector3 p = {0,1,0};
    normals[0] = p;
    p.y = -1;
    normals[vertCount - 1] = p;
    
    
    if (self.rings % 2 == 1) {
        _RMVector3 p = {1,0,0};
        
        int midIdx= (vertCount-1)/2;
        
        normals[midIdx] = p;
        
        float offset = M_PI/(vertCount-2+1);
        float angle = offset;
        for (int i = (midIdx-1); i > 0; --i) {
            _RMVector3 r = RMRotateZVector3(angle, p);
            normals[i] = r;
            
            r.y = -r.y;
            normals[midIdx + (midIdx - i)] = r;
            
            angle+=offset;
        }
    } else {
        _RMVector3 p = {1,0,0};
        
        int baseIdx= vertCount/2;
        
        normals[baseIdx] = p;
        
        float offset = M_PI/(vertCount-2);
        float angle = offset/2;
        for (int i = baseIdx; i > 0; --i) {
            _RMVector3 r = RMRotateZVector3(angle, p);
            normals[i] = r;
            
            r.y = -r.y;
            normals[2*baseIdx - i] = r;
            
            angle+=offset;
        }
    }
    
    NSMutableArray<RMMeshVertex3D*>* baseVertexArray = [NSMutableArray arrayWithCapacity:vertCount];
    
    for (int i = 0; i < vertCount; ++i)
    {
        [baseVertexArray addObject:
         [RMMeshVertex3D vertexWithPosition:[RMVector3 vectorWithRMVector:RMScaleVector3(self.radius, normals[i])]
                                     normal:self.smoothNormals ? [RMVector3 vectorWithRMVector:normals[i]] : nil
                                        uv0:[RMVector2 vectorWithX:0 y:i*(1.0/vertCount)]]];
    }
    
    NSMutableArray<RMMeshVertex3D*>* lastVertexArray = [baseVertexArray mutableCopy];
    NSMutableArray<RMMeshVertex3D*>* secondVertexArray = [baseVertexArray mutableCopy];
    
    float angleSeg = 2*M_PI/self.segments;
    
    for (int segment = 1; segment < self.segments ; segment++) {
        
        
        for (int i = 0; i < vertCount; ++i)
        {
            
            _RMVector3 rotNorm = RMRotateYVector3(angleSeg*segment, normals[i]);
            
            secondVertexArray[i] =
            [RMMeshVertex3D vertexWithPosition:[RMVector3 vectorWithRMVector:RMScaleVector3(self.radius, rotNorm)]
                                        normal:self.smoothNormals ? [RMVector3 vectorWithRMVector:rotNorm] : nil
                                           uv0:[RMVector2 vectorWithX:segment*(1.0/self.segments) y:i*(1.0/vertCount)]];
            
        }
        
        [builder appendTriangle:[RMMeshTriangle3D triangleWithVertexA:lastVertexArray[0] b:secondVertexArray[1] c:lastVertexArray[1]]];
        
        
        for (int i = 1; i < (vertCount-2); ++i)
        {
            [builder appendQuad:[RMMeshQuad3D quadWithVertexA:lastVertexArray[i]
                                                            b:secondVertexArray[i]
                                                            c:secondVertexArray[i+1]
                                                            d:lastVertexArray[i+1]]];
        }
        
         [builder appendTriangle:[RMMeshTriangle3D triangleWithVertexA:lastVertexArray[vertCount-2] b:secondVertexArray[vertCount-2] c:secondVertexArray[vertCount-1]]];
        
        
        lastVertexArray = [secondVertexArray mutableCopy];
        
    }
    
    for (int i = 0; i < (vertCount - 1); ++i) {
        RMMeshVertex3D* vert3d = baseVertexArray[i];
        
        secondVertexArray[i] = [RMMeshVertex3D vertexWithPosition:vert3d.position
                                    normal:vert3d.normal
                                       uv0:[RMVector2 vectorWithX:1 y:i*(1.0/vertCount)]];
    }
    
    [builder appendTriangle:[RMMeshTriangle3D triangleWithVertexA:lastVertexArray[0] b:secondVertexArray[1] c:lastVertexArray[1]]];
    
    for (int i = 1; i < (vertCount-2); ++i)
    {
        [builder appendQuad:[RMMeshQuad3D quadWithVertexA:lastVertexArray[i]
                                                        b:secondVertexArray[i]
                                                        c:secondVertexArray[i+1]
                                                        d:lastVertexArray[i+1]]];
        
    }
    
    [builder appendTriangle:[RMMeshTriangle3D triangleWithVertexA:lastVertexArray[vertCount-2] b:secondVertexArray[vertCount-2] c:secondVertexArray[vertCount-1]]];
}

@end
