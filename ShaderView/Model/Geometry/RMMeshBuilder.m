//
//  RMMeshBuilder.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/2/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMeshBuilder.h"

#import "RMVector.h"

#import "RMTriangle3D.h"
#import "RMQuad3D.h"

#import "RMVBOVertexAttribute.h"

#import "RMVBOVertexBuffer.h"
#import "RMGLVBOObject.h"

#import "RMMesh.h"

@interface RMMeshBuilder ()

@property (nonatomic,  readonly) NSMutableArray<RMTriangle3D*>* triangles;
@end

@implementation RMMeshBuilder


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _triangles = [NSMutableArray array];
    }
    return self;
}

- (nonnull RMMesh*)build
{
    NSInteger trisCount = self.triangles.count;
    
    float vertex[trisCount*3*3];
    NSInteger index = 0;
    for (RMTriangle3D* triangle in self.triangles)
    {
        vertex[index] = triangle.a.vector.x;
        vertex[index + 1] = triangle.a.vector.y;
        vertex[index + 2] = triangle.a.vector.z;
        index += 3;
        
        vertex[index] = triangle.b.vector.x;
        vertex[index + 1] = triangle.b.vector.y;
        vertex[index + 2] = triangle.b.vector.z;
        index += 3;
        
        vertex[index] = triangle.c.vector.x;
        vertex[index + 1] = triangle.c.vector.y;
        vertex[index + 2] = triangle.c.vector.z;
        index += 3;
    }
    
    NSArray<RMVBOVertexAttribute*> *attrs = @[
                                              [RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypePosition offset:0 size:RMVBOVertexAttributeSize_3],
                                              ];
    
    RMVBOVertexBuffer* vb = [RMVBOVertexBuffer buffer:vertex
                                                 type:RMVBODataBufferTypeStatic
                                                count:trisCount*3
                                             dataSize:trisCount*3*3*sizeof(float)
                                           attributes:attrs
                                            primitive:RMVBOVertexBufferPrimitiveTriangle];
    
    
    return [RMMesh meshWithVBO:[RMGLVBOObject objectWithVertexData:vb indexData:nil]];
}

- (void)reset
{
     _triangles = [NSMutableArray array];
}

- (void)appendTriangle:(RMTriangle3D*)triangle
{
    [self.triangles addObject:triangle];
}

- (void)appendQuad:(RMQuad3D*)quad
{
    [self appendTriangle:[RMTriangle3D triangleWithPointA:quad.a b:quad.b c:quad.c]];
    [self appendTriangle:[RMTriangle3D triangleWithPointA:quad.c b:quad.d c:quad.a]];;
}


@end
