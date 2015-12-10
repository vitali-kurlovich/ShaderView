//
//  RMTestRenderScene.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTestPostEffectRenderScene.h"

#import "RMGLSLProgram.h"

#import "RMVertexAttribute.h"

#import "RMVBOBuffer.h"
#import "RMVBOObject.h"

#import "RMVBOVertexBuffer.h"



@interface RMTestPostEffectRenderScene ()

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

@implementation RMTestPostEffectRenderScene

@synthesize quadObject = _quadObject;

- (instancetype)initWithVertexShader:(NSString *)vs fragmentShader:(NSString *)fs
{
    NSArray<RMVertexAttribute*>* attributes =
    @[
      [RMVertexAttribute attributeWithName:@"Position" attribute:RMVBOVertexAttributeTypePosition]
      ];
    
    self = [super initWithVertexShader:vs fragmentShader:fs attributes:attributes];
   
    return self;
}

+ (Class)programClass
{
    return [RMGLSLProgram class];
}

- (RMVBOObject*)quadObject
{
    if (_quadObject == nil)
    {
        NSArray<RMVBOVertexAttribute*> *attrs = @[
                                                  [RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypePosition offset:0 size:RMVBOVertexAttributeSize_2],
                                                  ];
        
        RMVBOVertexBuffer* vb = [RMVBOVertexBuffer buffer:quad
                                                     type:RMVBODataBufferTypeStatic
                                                    count:sizeof(quad)/sizeof(Vert2D)
                                                 dataSize:sizeof(quad)
                                               attributes:attrs
                                                primitive:RMVBOVertexBufferPrimitiveTriangleStrip];
        
        _quadObject = [RMVBOObject objectWithVertexData:vb indexData:nil];
       
    }
    return _quadObject;
}


#pragma mark - RMRenderViewDelegate

- (void)renderView:(nullable RMRenderView*)renderView  preRenderWithDuration:(rmtime)deltaTime
{
    glClearColor(1, 0, 0, 1);
    
    glClear(GL_COLOR_BUFFER_BIT );
    glDisable(GL_DEPTH_TEST);
       
}


- (void)renderView:(nullable RMRenderView*)renderView  renderWithDuration:(rmtime)deltaTime
{
    [self.program useProgramBegin];
    [self.program prepareForUseVBOBuffer:self.quadObject.vertexBuffer];
    
   // [self.quadObject draw];
    
    [self.program useProgramEnd];
}

@end
