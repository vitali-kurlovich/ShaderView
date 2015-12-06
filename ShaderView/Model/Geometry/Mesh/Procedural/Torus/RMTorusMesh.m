//
//  RMTorusMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/6/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTorusMesh.h"

#import "RMMath.h"

#import "RMMeshBuilder.h"

#import "RMMeshQuad3D.h"
#import "RMMeshTriangle3D.h"
#import "RMMeshVertex3D.h"


@implementation RMTorusMesh
- (instancetype)initWithFormat:(RMVBOVertexAttributeType)format
{
    self = [super initWithFormat:format];
    if (self)
    {
        _rings = 12;
        _segments = 32;
        _minorRadius = 0.4;
        _majorRadius = 1;
        
        self.smoothNormals = YES;
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

- (void)setMajorRadius:(float)majorRadius
{
    if (_majorRadius != majorRadius)
    {
        _majorRadius = majorRadius;
        [self setNeedsRebuild];
    }
}

- (void)setMinorRadius:(float)minorRadius
{
    if (_minorRadius != minorRadius)
    {
        _minorRadius = minorRadius;
        [self setNeedsRebuild];
    }
}


- (void)build:(RMMeshBuilder*)builder
{
    NSUInteger vertCount = self.rings;
    
    _RMVector3 normals[vertCount];
    _RMVector3 pos[vertCount];

    _RMVector3 p = {1,0,0};
    normals[0] = p;
    
    _RMVector3 majorOffset = {self.majorRadius, 0, 0};
    
    pos[0] = RMSumVector3(RMScaleVector3(self.minorRadius, p), majorOffset);
    
    float offset = 2*M_PI/(vertCount);
    float angle = offset;
    
    for (int i = 1; i < vertCount; ++i)
    {
        _RMVector3 r = RMRotateZVector3(angle, p);
        
        normals[i] = r;
        r = RMScaleVector3(self.minorRadius, r);
        pos[i] = RMSumVector3(r, majorOffset);
        
        angle += offset;  
    }


    NSMutableArray<RMMeshVertex3D*>* baseVertexArray = [NSMutableArray arrayWithCapacity:vertCount];
    
    for (int i = 0; i < vertCount; ++i)
    {
        [baseVertexArray addObject:
         [RMMeshVertex3D vertexWithPosition:[RMVector3 vectorWithRMVector:pos[i]]
                                     normal:self.smoothNormals ? [RMVector3 vectorWithRMVector:normals[i]] : nil
                                        uv0:[RMVector2 vectorWithX:0 y:i*(1.0/vertCount)]]];
    }
    
    [baseVertexArray addObject:[baseVertexArray firstObject]];

    NSMutableArray<RMMeshVertex3D*>* lastVertexArray = [baseVertexArray mutableCopy];
    NSMutableArray<RMMeshVertex3D*>* secondVertexArray = [baseVertexArray mutableCopy];
    
    float angleSeg = 2*M_PI/self.segments;

    for (int segment = 1; segment < self.segments ; segment++) {
        
        
        for (int i = 0; i < vertCount; ++i)
        {
            
            _RMVector3 rotNorm = RMRotateYVector3(angleSeg*segment, normals[i]);
            _RMVector3 rotPos = RMRotateYVector3(angleSeg*segment, pos[i]);
            
            secondVertexArray[i] =
            [RMMeshVertex3D vertexWithPosition:[RMVector3 vectorWithRMVector:rotPos]
                                        normal:self.smoothNormals ? [RMVector3 vectorWithRMVector:rotNorm] : nil
                                           uv0:[RMVector2 vectorWithX:segment*(1.0/self.segments) y:i*(1.0/vertCount)]];
            
        }
        
        secondVertexArray[vertCount] = [secondVertexArray firstObject];
        
        for (int i = 0; i < vertCount; ++i)
        {
            [builder appendQuadWithVertexA:lastVertexArray[i] b:secondVertexArray[i] c:secondVertexArray[i+1] d:lastVertexArray[i+1]];
        }
        
        id swapArray = lastVertexArray;
        lastVertexArray = secondVertexArray;
        secondVertexArray = swapArray;
    }
    
    
    
    for (int i = 0; i < vertCount; ++i) {
        RMMeshVertex3D* vert3d = baseVertexArray[i];
        
        secondVertexArray[i] = [RMMeshVertex3D vertexWithPosition:vert3d.position
                                                           normal:vert3d.normal
                                                              uv0:[RMVector2 vectorWithX:1 y:i*(1.0/vertCount)]];
    }
    
    for (int i = 0; i < vertCount; ++i)
    {
        [builder appendQuadWithVertexA:lastVertexArray[i] b:secondVertexArray[i] c:secondVertexArray[i+1] d:lastVertexArray[i+1]];
    }
    
}



@end
