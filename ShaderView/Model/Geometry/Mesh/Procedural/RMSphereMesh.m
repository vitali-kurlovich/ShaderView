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

- (nonnull instancetype)initWithFormat:(RMVBOVertexAttributeType)format
{
    self = [super initWithFormat:format];
    if (self)
    {
        _rings = 5;
        _segments = 12;
        _radius = 1;
        _smoothNormals = YES;
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
    
    
    if (self.rings % 2 == 1)
    {
        _RMVector3 p = {1,0,0};
        
        int midIdx= (vertCount-1)/2;
        
        normals[midIdx] = p;
        
        
        float offset = M_PI/(vertCount-2+1);
        float angle = offset;
        for (int i = (midIdx-1); i > 0; --i)
        {
            _RMVector3 r = RMRotateZVector3(angle, p);
            normals[i] = r;
            
            r.y = -r.y;
            normals[midIdx + (midIdx - i)] = r;
            
            angle+=offset;
        }
    }
    
    
    RMMeshVertex3D* topVert = [RMMeshVertex3D vertexWithPosition:[RMVector3 vectorWithRMVector:RMScaleVector3(self.radius, normals[0])]
                                                          normal:self.smoothNormals ?  [RMVector3 vectorWithRMVector:normals[0]] : nil
                                                             uv0:[RMVector2 vectorWithX:0.5 y:1]];
    
    RMMeshVertex3D* bottomVert = [RMMeshVertex3D vertexWithPosition:[RMVector3 vectorWithRMVector:RMScaleVector3(self.radius, normals[vertCount-1])]
                                                             normal:self.smoothNormals ? [RMVector3 vectorWithRMVector:normals[vertCount-1]] : nil
                                                                uv0:[RMVector2 vectorWithX:0.5 y:0]];
    
    
    
    
    NSMutableArray<RMMeshVertex3D*>* baseVertexArray = [NSMutableArray arrayWithCapacity:vertCount];
    
    [baseVertexArray addObject:topVert];
    
    for (int i = 1; i < (vertCount-1); ++i)
    {
        [baseVertexArray addObject:
         [RMMeshVertex3D vertexWithPosition:[RMVector3 vectorWithRMVector:RMScaleVector3(self.radius, normals[i])]
                                     normal:self.smoothNormals ? [RMVector3 vectorWithRMVector:normals[i]] : nil
                                        uv0:[RMVector2 vectorWithX:0 y:i*(1.0/vertCount)]]];
    }
    
    [baseVertexArray addObject:bottomVert];
    
    NSMutableArray<RMMeshVertex3D*>* lastVertexArray = [baseVertexArray mutableCopy];
    NSMutableArray<RMMeshVertex3D*>* secondVertexArray = [baseVertexArray mutableCopy];
    
    float angleSeg = 2*M_PI/self.segments;
    
    for (int segment = 0; segment < self.segments - 1; segment++) {
        
        
        for (int i = 1; i < (vertCount-2); ++i)
        {
            
            _RMVector3 rotNorm = RMRotateYVector3(angleSeg*segment, normals[i]);
            
            secondVertexArray[i] =
            [RMMeshVertex3D vertexWithPosition:[RMVector3 vectorWithRMVector:RMScaleVector3(self.radius, rotNorm)]
                                        normal:self.smoothNormals ? [RMVector3 vectorWithRMVector:rotNorm] : nil
                                           uv0:[RMVector2 vectorWithX:segment*(1.0/self.segments) y:i*(1.0/vertCount)]];
            
            
            
            
        }
        
        for (int i = 1; i < (vertCount-2); ++i)
        {
            [builder appendQuad:[RMMeshQuad3D quadWithVertexA:lastVertexArray[i]
                                                            b:secondVertexArray[i]
                                                            c:secondVertexArray[i+1]
                                                            d:lastVertexArray[i+1]]];
            
        }
        
        lastVertexArray = [secondVertexArray mutableCopy];
        //
    }
}

@end
