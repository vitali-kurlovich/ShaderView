//
//  RMProceduralMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMProceduralMesh.h"

#import "RMMeshBuilder.h"
#import "RMVBOObject.h"

@interface RMProceduralMesh()
@property (nonatomic, readonly) RMMesh* mesh;
@property (nonatomic, readonly) RMMeshBuilder* meshBuilder;
@end

@implementation RMProceduralMesh
@synthesize mesh = _mesh;
@synthesize meshBuilder = _meshBuilder;

- (instancetype)init
{
    return [self initWithFormat:(RMVBOVertexAttributeTypePosition | RMVBOVertexAttributeTypeNormal | RMVBOVertexAttributeTypeUV0)];
}

- (nonnull instancetype)initWithFormat:(RMVBOVertexAttributeType)format
{
    self = [super init];
    if (self)
    {
        _format = format;
    }
    return self;
}

- (void)setSmoothNormals:(BOOL)smoothNormals
{
    if (_smoothNormals != smoothNormals)
    {
        _smoothNormals = smoothNormals;
        [self smoothNormals];
    }
}


- (RMVBOObject*)vbo
{
    return self.mesh.vbo;
}


- (RMMeshBuilder*)meshBuilder
{
    if (_meshBuilder == nil)
    {
        _meshBuilder = [[RMMeshBuilder alloc] initWithFormat:self.format];
    }
    return _meshBuilder;
}

- (RMMesh*)mesh
{
    if (_mesh == nil)
    {
        RMMeshBuilder* builder = self.meshBuilder;
        [self build:builder];
        _mesh = [builder build];
        [_mesh.vbo prepareBuffer];
        
        [builder reset];
    }
    
    return _mesh;
}


- (void)build:(RMMeshBuilder*)builder
{

}

- (void)setNeedsRebuild
{
    _mesh = nil;
}

@end
