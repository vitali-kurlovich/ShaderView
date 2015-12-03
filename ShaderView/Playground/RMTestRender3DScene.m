//
//  RMTestRender3DScene.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTestRender3DScene.h"

#import "RMGLSLProgram.h"

#import "RMCamera.h"


#import "RMVBOBuffer.h"
#import "RMGLVBOObject.h"

#import "RMVBOVertexBuffer.h"
#import "RMVBOVertexAttribute.h"

#import "RMVBOObject+RMDrawable.h"

#import "RMGLTexture.h"

#import "RMMath.h"

#import "RMMatrix4x4.h"
#import "RMVertexAttribute.h"

@import QuartzCore;

@interface RMTestRender3DScene ()
@property (nullable, readonly) RMTexture* texture;
@property (nonatomic, readonly) RMCamera* camera;

@property (nonatomic) RMVBOObject* object;
@end

typedef struct {
    _RMVector3 pos;
    _RMVector2 uv;
    
} VSStruct;

#define TEX_COORD_MAX   1

const VSStruct Vertices[] = {
    // Front
    {{1, -1, 0}, {TEX_COORD_MAX, 0}},
    {{1, 1, 0},  {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, 0},  {0, TEX_COORD_MAX}},
    {{-1, -1, 0},  {0, 0}},
    // Back
    {{1, 1, -2}, {TEX_COORD_MAX, 0}},
    {{-1, 1, -2},  {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, -1, -2},  {0, TEX_COORD_MAX}},
    {{1, -1, -2},  {0, 0}},
    // Left
    {{-1, -1, 0},  {TEX_COORD_MAX, 0}},
    {{-1, 1, 0},  {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -2},  {0, TEX_COORD_MAX}},
    {{-1, -1, -2},  {0, 0}},
    // Right
    {{1, -1, -2},  {TEX_COORD_MAX, 0}},
    {{1, 1, -2},  {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{1, 1, 0},  {0, TEX_COORD_MAX}},
    {{1, -1, 0},  {0, 0}},
    // Top
    {{1, 1, 0},  {TEX_COORD_MAX, 0}},
    {{1, 1, -2},  {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -2},  {0, TEX_COORD_MAX}},
    {{-1, 1, 0},  {0, 0}},
    // Bottom
    {{1, -1, -2},  {TEX_COORD_MAX, 0}},
    {{1, -1, 0},  {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, -1, 0},  {0, TEX_COORD_MAX}},
    {{-1, -1, -2},  {0, 0}}
};

const GLubyte Indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 5, 6,
    6, 7, 4,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};


@implementation RMTestRender3DScene

@synthesize texture = _texture;
@synthesize object = _object;
@synthesize camera = _camera;


+ (Class)programClass
{
    return [RMGLSLProgram class];
}

- (instancetype)initWithVertexShader:(NSString*)vs fragmentShader:(NSString*)fs
{
    NSArray<RMVertexAttribute*>* attributes =
    @[
      [RMVertexAttribute attributeWithName:@"pos" attribute:RMVBOVertexAttributeTypePosition],
      [RMVertexAttribute attributeWithName:@"uv0" attribute:RMVBOVertexAttributeTypeUV0]
      ];
    
    return [self initWithVertexShader:vs fragmentShader:fs attributes:attributes];
}

- (RMTexture*)texture
{
    if (_texture == nil)
    {
        _texture = [RMGLTexture textureNamed:@"testtexture"];
    }
    return _texture;
}


- (RMCamera*)camera
{
    if (_camera == nil)
    {
        float h = 4.0f ;//* self.frame.size.height / self.frame.size.width;
        _camera = [RMCamera3D cameraWithLeft:-2 right:2 top:h/2 bottom:-h/2 near:4 far:10];
    }
    return _camera;
}

- (RMVBOObject*)object
{
    if (_object == nil)
    {
        NSArray<RMVBOVertexAttribute*> *attr = @[
                                                 
                                                 [RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypePosition offset:0 size:RMVBOVertexAttributeSize_3],
                                                 [RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypeUV0 offset:sizeof(float)*(3) size:RMVBOVertexAttributeSize_2]
                                                 ];
        
        RMVBOVertexBuffer* vb = [RMVBOVertexBuffer buffer:(void*)Vertices count:sizeof(Vertices)/sizeof(VSStruct) dataSize:sizeof(Vertices) attributes:attr];
        
        RMVBOIndexBuffer* ib = [RMVBOIndexBuffer buffer:(void*)Indices count:sizeof(Indices)/sizeof(GLubyte) dataSize:sizeof(Indices)];
        
        _object = [RMGLVBOObject objectWithVertexData:vb indexData:ib];
        [_object prepareBuffer];
    }
    return _object;
}


#pragma mark - RMRenderDelegate

- (void)preRender:(RMRender*)render duration:(rmtime)deltaTime
{
    glClearColor(0.7, 0.7, 0.7, 1);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
   
}


- (void)render:(nullable RMRender*)render duration:(rmtime)deltaTime
{
    NSTimeInterval time = CACurrentMediaTime();
    RMMatrix4x4* translate = [RMMatrix4x4 translateMatrixWithX:sin(time) y:0 z:-7];
    RMMatrix4x4* rotate = [RMMatrix4x4 rotateMatrixWithAngle:time x:0.20739 y:0.829561 z:0.518476];
    RMMatrix4x4* model =  [[rotate mul:translate] mul:[self.camera matrix]];
    
    [self.program useProgramBegin];
    [self.program prepareForUseVBOBuffer:self.object.vertexBuffer];
    
    [self.program setParam:@"modelview" matrix:model];
    [self.program setParam:@"texture" texture:self.texture];
    
    [self.object draw];
    
    [self.program useProgramEnd];
}



@end
