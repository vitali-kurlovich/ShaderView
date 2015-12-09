//
//  RMMeshRender.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMeshRender.h"

#import "RMVBORender.h"
#import "RMMesh.h"
#import "RMVBOObject+Primitive.h"

@interface RMMeshRender ()
@property (nonatomic, readonly) RMVBOObject* solidVBO;
@property (nonatomic, readonly) RMVBOObject* wireframeVBO;
@end

@implementation RMMeshRender

@synthesize solidRender = _solidRender;
@synthesize wireframeRender = _wireframeRender;

@synthesize solidVBO = _solidVBO;
@synthesize wireframeVBO = _wireframeVBO;


- (void)setMesh:(RMMesh *)mesh
{
    if (_mesh != mesh)
    {
        _mesh = mesh;

        [self setMeshGeometryChanged];
    }
}

- (RMVBOObject*)solidVBO
{
    if (_solidVBO != self.mesh.vbo)
    {
        [self setMeshGeometryChanged];
    }
    
    if (_solidVBO == nil)
    {
        _solidVBO = self.mesh.vbo;
    }
    
    return _solidVBO;
}


- (RMVBOObject*)wireframeVBO
{
    if (_solidVBO != self.mesh.vbo)
    {
        [self setMeshGeometryChanged];
    }
    
    if (_wireframeVBO == nil)
    {
        _wireframeVBO = [self.solidVBO cloneVBOWithPrimitiveType:RMVBOVertexBufferPrimitiveLines];
    }
    
    return _wireframeVBO;
}

- (void)setMeshGeometryChanged
{
    _solidVBO = nil;
    _wireframeVBO = nil;
}


- (void)render
{
    switch (self.mode) {
        case RMMeshRenderSolid:
        {
            self.solidRender.vbo = self.solidVBO;
            [self.solidRender render];
        }
            break;
            
        case RMMeshRenderWireframe:
        {
            self.wireframeRender.vbo = self.wireframeVBO;
            [self.wireframeRender render];
        }
            break;
            
        default:
            break;
    }
}


- (void)setProgram:(RMProgram *)program
{
    super.program = program;
    self.solidRender.program = program;
    self.wireframeRender.program = program;
}

- (RMVBORender*)solidRender
{
    if (_solidRender == nil)
    {
        _solidRender = [RMVBORender render];
    }
    return _solidRender;
}

- (RMVBORender*)wireframeRender
{
    if (_wireframeRender == nil)
    {
        _wireframeRender = [RMVBORender render];
    }
    return _wireframeRender;
}

@end
