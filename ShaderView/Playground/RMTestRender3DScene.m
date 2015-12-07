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

#import "RMCubeMesh.h"
#import "RMSphereMesh.h"
#import "RMTorusMesh.h"

@import QuartzCore;

@interface RMTestRender3DScene ()
@property (nullable, readonly) RMTexture* texture;
@property (nonatomic, readonly) RMCamera* camera;

@property (nonatomic, readonly) RMMesh* cube;
@property (nonatomic, readonly) RMTorusMesh* torus;
@property (nonatomic, readonly) RMSphereMesh* sphere;
@end



@implementation RMTestRender3DScene

@synthesize texture = _texture;

@synthesize camera = _camera;
@synthesize cube = _cube;
@synthesize torus = _torus;
@synthesize sphere = _sphere;

+ (Class)programClass
{
    return [RMGLSLProgram class];
}

- (instancetype)initWithVertexShader:(NSString*)vs fragmentShader:(NSString*)fs
{
    NSArray<RMVertexAttribute*>* attributes =
    @[
      [RMVertexAttribute attributeWithName:@"pos" attribute:RMVBOVertexAttributeTypePosition],
      [RMVertexAttribute attributeWithName:@"normal" attribute:RMVBOVertexAttributeTypeNormal],
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


- (RMMesh*)cube
{
    if (_cube == nil)
    {
       
        _cube =  [RMCubeMesh mesh];
        
        _cube.program = self.program;
    }
    return _cube;
}


- (RMTorusMesh*)torus
{
    if (_torus == nil)
    {
        _torus = [RMTorusMesh mesh];
        _torus.program = self.program;
    }
    return _torus;
}

- (RMSphereMesh*)sphere
{
    if (_sphere == nil)
    {
        _sphere = [RMSphereMesh mesh];
        _sphere.program = self.program;
    }
    
    return _sphere;
}

#pragma mark - RMRenderDelegate

- (void)preRender:(RMRender*)render duration:(rmtime)deltaTime
{
    glClearColor(0.7, 0.7, 0.7, 1);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
   
    glEnable(GL_CULL_FACE);
   // glCullFace(GL_BACK);
}


- (void)render:(nullable RMRender*)render duration:(rmtime)deltaTime
{
    NSLog(@"fps:%@", @(1./deltaTime));
    
    NSTimeInterval time = CACurrentMediaTime();
    
    //self.torus.minorRadius = (sin(time)*0.5 + 0.5)*0.6 + 0.1;
    self.torus.smoothNormals = NO;
    
    RMMatrix4x4* translate = [RMMatrix4x4 translateMatrixWithX:sin(0) y:0 z:-7];
    RMMatrix4x4* rotate = [RMMatrix4x4 rotateMatrixWithAngle:time x:sin(time*0.33) y:cos(time*0.33) z:0];
    RMMatrix4x4* model =  [rotate mul:translate];
    
    [self.torus.program setParam:@"projection" matrix:[self.camera matrix]];
    
    [self.torus.program setParam:@"modelview" matrix:model];
    [self.torus.program setParam:@"invmodelview" matrix:[[model inverse] transpose]];
    
    [self.torus.program setParam:@"texture" texture:self.texture];
    
    [self.torus draw];
}



@end
