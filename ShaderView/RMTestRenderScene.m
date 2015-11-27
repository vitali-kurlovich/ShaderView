//
//  RMTestRenderScene.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTestRenderScene.h"
#import "RMGLSLProgram.h"


#import "RMVertexAttribute.h"

#import "RMVBOBuffer.h"
#import "RMGLVBOObject.h"

#import "RMVBOVertexBuffer.h"

#import "RMVBOObject+RMDrawable.h"

@interface RMTestRenderScene ()
@property (nonatomic, readonly) RMProgram* program;
@property (nonatomic, readonly) RMVBOObject* quadObject;
@end


typedef struct {
    float Position[2];
    float TexCoord[2];
} Vert2D;



static Vert2D quad[]  = {
    {{-1, -1}, {0,0}},
    {{1, -1}, {1,0}},
    {{-1, 1}, {1,1}},
    {{1, 1}, {0,1}},
};

@implementation RMTestRenderScene

@synthesize quadObject = _quadObject;

- (instancetype)initWithVertexShader:(NSString *)vs fragmentShader:(NSString *)fs
{
    self = [super init];
    if (self)
    {
        NSArray<RMVertexAttribute*>* attributes =
        @[
          [RMVertexAttribute attributeWithName:@"Position" attribute:RMVBOVertexAttributeTypePosition]
          ];
        _program = [[RMGLSLProgram alloc] initWithVertexShader:vs fragmentShader:fs attributes:attributes];
    }
    
    return self;
}


- (RMVBOObject*)quadObject
{
    if (_quadObject == nil)
    {
        NSArray<RMVBOVertexAttribute*> *attrs = @[
                                                  [RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypePosition offset:0 size:RMVBOVertexAttributeSize_2],
                                                  ];
        
        RMVBOVertexBuffer* vb = [RMVBOVertexBuffer buffer:quad type:RMVBODataBufferTypeDynamic count:sizeof(quad)/sizeof(Vert2D) dataSize:sizeof(quad) attributes:attrs primitive:RMVBOVertexBufferPrimitiveTriangleStrip];
        
        _quadObject = [RMGLVBOObject objectWithVertexData:vb indexData:nil];
        [_quadObject prepareBuffer];
    }
    return _quadObject;
}


#pragma mark - RMRenderDelegate <NSObject>

- (void)preRender:(nullable RMRender*)render duration:(rmtime)deltaTime
{
    glClearColor(1, 0, 0, 1);
    
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glEnable(GL_DEPTH_TEST);
       
}

- (void)postRender:(nullable RMRender*)render duration:(rmtime)deltaTime
{
    
}

- (void)render:(nullable RMRender*)render duration:(rmtime)deltaTime
{
     [self.program useProgramBegin];
    [self.program prepareForUseVBOBuffer:self.quadObject.vertexBuffer];
    
    [self.quadObject draw];
    
    [self.program useProgramEnd];
}

@end
