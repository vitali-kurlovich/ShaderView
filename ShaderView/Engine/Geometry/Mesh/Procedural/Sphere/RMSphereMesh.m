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


@interface RMSphereMesh ()
@property (nonatomic, readonly) NSUInteger segments;
@property (nonatomic, readonly) NSUInteger rings;
@property (nonatomic, readonly) float radius;
@end

@implementation RMSphereMesh

- (instancetype)initWithFormat:(RMVBOVertexAttributeType)format
{
    self = [super initWithFormat:format];
    if (self)
    {
        self.smoothNormals = YES;
    }
    return self;
}

- (void)awakeProceduralMesh
{
    [self registrateMeshParamWithName:@"rings" type:RMProceduralMeshParamValueTypeInt value:@(25) defaultValue:@(16) minValue:@(4) maxValue:@(64)];
    [self registrateMeshParamWithName:@"segments" type:RMProceduralMeshParamValueTypeInt value:@(32) defaultValue:@(16) minValue:@(6) maxValue:@(96)];
    
    [self registrateMeshParamWithName:@"radius" type:RMProceduralMeshParamValueTypeFloat value:@(1) defaultValue:@(1) minValue:@(0) maxValue:@(100)];
   
}

- (NSUInteger)segments
{
    return [[self paramByName:@"segments"].value unsignedIntegerValue];
}

- (NSUInteger)rings
{
    return [[self paramByName:@"rings"].value unsignedIntegerValue];
}

- (float)radius
{
    return [[self paramByName:@"radius"].value floatValue];
}

- (void)build:(RMMeshBuilder*)builder
{
    unsigned int vertCount = self.rings + 2;
    
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
        
        
        for (int i = 0; i < vertCount; ++i) {
            
            _RMVector3 rotNorm = RMRotateYVector3(angleSeg*segment, normals[i]);
            
            secondVertexArray[i] =
            [RMMeshVertex3D vertexWithPosition:[RMVector3 vectorWithRMVector:RMScaleVector3(self.radius, rotNorm)]
                                        normal:self.smoothNormals ? [RMVector3 vectorWithRMVector:rotNorm] : nil
                                           uv0:[RMVector2 vectorWithX:segment*(1.0/self.segments) y:i*(1.0/vertCount)]];
            
        }
        
        [builder appendTriangleWithVertexA:lastVertexArray[1] b:secondVertexArray[1] c:lastVertexArray[0]];
        
        for (int i = 1; i < (vertCount-2); ++i)
        {
            [builder appendQuadWithVertexA:lastVertexArray[i+1] b:secondVertexArray[i+1] c:secondVertexArray[i] d:lastVertexArray[i]];
        }
        
        [builder appendTriangleWithVertexA:secondVertexArray[vertCount-1] b:secondVertexArray[vertCount-2] c:lastVertexArray[vertCount-2]];
        
        id swapArray = lastVertexArray;
        lastVertexArray = secondVertexArray;
        secondVertexArray = swapArray;
    }
    
    for (int i = 0; i < (vertCount - 1); ++i) {
        RMMeshVertex3D* vert3d = baseVertexArray[i];
        
        secondVertexArray[i] = [RMMeshVertex3D vertexWithPosition:vert3d.position
                                    normal:vert3d.normal
                                       uv0:[RMVector2 vectorWithX:1 y:i*(1.0/vertCount)]];
    }
    
    [builder appendTriangleWithVertexA:lastVertexArray[1] b:secondVertexArray[1] c:lastVertexArray[0]];
    
    for (int i = 1; i < (vertCount-2); ++i)
    {
        [builder appendQuadWithVertexA:lastVertexArray[i+1] b:secondVertexArray[i+1] c:secondVertexArray[i] d:lastVertexArray[i]];
    }
    
    [builder appendTriangleWithVertexA:secondVertexArray[vertCount-1] b:secondVertexArray[vertCount-2] c:lastVertexArray[vertCount-2]];
}

@end
