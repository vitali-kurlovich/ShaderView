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
#import "RMVBOObject.h"

#import "RMVBOVertexBuffer.h"
#import "RMVBOVertexAttribute.h"



#import "RMGLTexture.h"

#import "RMMath.h"

#import "RMMatrix4x4.h"
#import "RMVertexAttribute.h"

#import "RMCubeMesh.h"
#import "RMSphereMesh.h"
#import "RMTorusMesh.h"

#import "RMRender.h"

#import "RMVBORender.h"

#import "RMVBOObject+Primitive.h"

@import QuartzCore;

@interface RMTestRender3DScene ()
@property (nullable, readonly) RMTexture* texture;

@property (nonatomic, readonly) RMVBORender* vboRender;

@property (nonatomic, readonly) RMMesh* cube;
@property (nonatomic, readonly) RMTorusMesh* torus;
@property (nonatomic, readonly) RMTorusMesh* torusW;

@property (nonatomic, readonly) RMSphereMesh* sphere;
@end



@implementation RMTestRender3DScene

@synthesize vboRender = _vboRender;

@synthesize texture = _texture;


@synthesize cube = _cube;
@synthesize torus = _torus;

@synthesize torusW = _torusW;

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


- (RMVBORender*)vboRender
{
    if (_vboRender == nil)
    {
        _vboRender = [RMVBORender render];
    }
    return _vboRender;
}

- (RMTexture*)texture
{
    if (_texture == nil)
    {
        _texture = [RMGLTexture textureNamed:@"testtexture"];
    }
    return _texture;
}


- (RMCamera*)cameraWithFrame:(CGRect)frame
{
        float h = 4.0f * frame.size.height / frame.size.width;
        return [RMCamera3D cameraWithLeft:-2 right:2 top:h/2 bottom:-h/2 near:4 far:10];
}


- (RMMesh*)cube
{
    if (_cube == nil)
    {
        
        _cube =  [RMCubeMesh mesh];
        
        
    }
    return _cube;
}


- (RMTorusMesh*)torus
{
    if (_torus == nil)
    {
        _torus = [RMTorusMesh mesh];
       
    }
    return _torus;
}




- (RMSphereMesh*)sphere
{
    if (_sphere == nil)
    {
        _sphere = [RMSphereMesh mesh];
       
    }
    
    return _sphere;
}

#pragma mark - RMRenderViewDelegate

- (void)renderView:(nullable RMRenderView*)renderView  preRenderWithDuration:(rmtime)deltaTime
{
    glClearColor(0.7, 0.7, 0.7, 1);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
    
    glEnable(GL_CULL_FACE);
    // glCullFace(GL_BACK);
}


- (void)renderView:(nullable RMRenderView*)renderView  renderWithDuration:(rmtime)deltaTime
{
    //NSLog(@"fps:%@", @(1./deltaTime));
    
    NSTimeInterval time = CACurrentMediaTime();
    
    //self.torus.minorRadius = (sin(time)*0.5 + 0.5)*0.6 + 0.1;
    self.torus.smoothNormals = NO;
    
    RMMatrix4x4* translate = [RMMatrix4x4 translateMatrixWithX:sin(0) y:0 z:-7];
    RMMatrix4x4* rotate = [RMMatrix4x4 rotateMatrixWithAngle:time x:sin(time*0.33) y:cos(time*0.33) z:0];
    RMMatrix4x4* model =  [rotate mul:translate];
    
    
    [self.program setParam:@"light" vector3:[RMVector3 vectorWithX:2 y:8 z:14]];
    [self.program setParam:@"specularPower" floatValue:(sin(time*0.15) + 1)*0.5*26+2];
    
    [self.program setParam:@"projection" matrix:[[self cameraWithFrame:renderView.frame] matrix]];
    
    [self.program setParam:@"modelview" matrix:model];
    [self.program setParam:@"invmodelview" matrix:[[model inverse] transpose]];
    
    [self.program setParam:@"texture" texture:self.texture];
    
    self.vboRender.program = self.program;
    
    self.vboRender.vbo = [self.torus.vbo cloneVBOWithPrimitiveType:RMVBOVertexBufferPrimitiveLines];
    
    [self.vboRender render];
    
    
    translate = [RMMatrix4x4 translateMatrixWithX:sin(time) y:0 z:-8];
    model =  [rotate mul:translate];
    [self.program setParam:@"modelview" matrix:model];
    
    self.vboRender.vbo = self.sphere.vbo;
    
    [self.vboRender render];
}



@end
