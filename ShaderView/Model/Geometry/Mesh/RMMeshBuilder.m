//
//  RMMeshBuilder.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/2/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMeshBuilder.h"

#import "RMMath.h"

#import "RMMeshTriangle3D.h"
#import "RMMeshQuad3D.h"

#import "RMVBOVertexAttribute.h"

#import "RMVBOVertexBuffer.h"
#import "RMGLVBOObject.h"

#import "RMMesh.h"

#import "RMMeshVertex3D.h"


@interface RMMeshBuilder ()

@property (nonatomic,  readonly) NSMutableArray<RMMeshVertex3D*>* vertexArray;
@property (nonatomic,  readonly) NSMutableSet<RMMeshVertex3D*>* vertexSet;
@property (nonatomic, readonly) RMVector2* zeroVector2;
@property (nonatomic, readonly) RMVector3* zeroVector3;
@property (nonatomic, readonly) RMVector4* zeroVector4;



@end

@implementation RMMeshBuilder
@synthesize attributes = _attributes;

- (instancetype)init
{
    return  [self initWithFormat:(RMVBOVertexAttributeTypePosition | RMVBOVertexAttributeTypeUV0)];
}


- (nonnull instancetype)initWithFormat:(RMVBOVertexAttributeType)format
{
    self = [super init];
    if (self)
    {
        _vertexArray = [NSMutableArray array];
        _vertexSet = [NSMutableSet set];
        
        _format = format;
        
        _zeroVector2 = [RMVector2 vectorWithX:0 y:0];
        _zeroVector3 = [RMVector3 vectorWithX:0 y:0 z:0];
        _zeroVector4 = [RMVector4 vectorWithX:0 y:0 z:0 w:0];
        
    }
    return self;
}


- (nonnull RMMesh*)build
{
    NSArray<RMVBOVertexAttribute*>* attributes = self.attributes;
    RMVBOVertexAttribute* last = [attributes lastObject];
    
    NSInteger patchSize = last.offset/sizeof(float) + last.size;
    NSInteger vertCount = self.vertexArray.count;
    
    float vertexBuffer[vertCount*patchSize];
    
    for (RMVBOVertexAttribute* attr in attributes)
    {
        NSInteger offset = attr.offset/sizeof(float);
        
        if (attr.type == RMVBOVertexAttributeTypePosition) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in self.vertexArray)
            {
                vertexBuffer[index] = vert.position.vector.x;
                vertexBuffer[index + 1] = vert.position.vector.y;
                vertexBuffer[index + 2] = vert.position.vector.z;
                
                index += patchSize;
            }
            continue;
        }
        
        if (attr.type == RMVBOVertexAttributeTypeNormal) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in self.vertexArray)
            {
                vertexBuffer[index] = vert.normal.vector.x;
                vertexBuffer[index + 1] = vert.normal.vector.y;
                vertexBuffer[index + 2] = vert.normal.vector.z;
                index += patchSize;
            }
            continue;
        }

        if (attr.type == RMVBOVertexAttributeTypeColor) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in self.vertexArray)
            {
                vertexBuffer[index] = vert.color.vector.x;
                vertexBuffer[index + 1] = vert.color.vector.y;
                vertexBuffer[index + 2] = vert.color.vector.z;
                vertexBuffer[index + 3] = vert.color.vector.w;
                index += patchSize;
            }
            continue;
        }
        
        if (attr.type == RMVBOVertexAttributeTypeUV0) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in self.vertexArray)
            {
                vertexBuffer[index] = vert.uv0.vector.x;
                vertexBuffer[index + 1] = vert.uv0.vector.y;
                
                index += patchSize;
            }
            continue;
        }
        
        if (attr.type == RMVBOVertexAttributeTypeUV1) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in self.vertexArray)
            {
                vertexBuffer[index] = vert.uv1.vector.x;
                vertexBuffer[index + 1] = vert.uv1.vector.y;
                
                index += patchSize;
            }
            continue;
        }
        
        if (attr.type == RMVBOVertexAttributeTypeUV2) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in self.vertexArray)
            {
                vertexBuffer[index] = vert.uv2.vector.x;
                vertexBuffer[index + 1] = vert.uv2.vector.y;
                
                index += patchSize;
            }
            continue;
        }
        
        if (attr.type == RMVBOVertexAttributeTypeUV3) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in self.vertexArray)
            {
                vertexBuffer[index] = vert.uv3.vector.x;
                vertexBuffer[index + 1] = vert.uv3.vector.y;
                
                index += patchSize;
            }
            continue;
        }
    }
    
    RMVBOVertexBuffer* vb = [RMVBOVertexBuffer buffer:vertexBuffer
                                                 type:RMVBODataBufferTypeStatic
                                                count:vertCount
                                             dataSize:vertCount*patchSize*sizeof(float)
                                           attributes:attributes
                                            primitive:RMVBOVertexBufferPrimitiveTriangle];
    
    
    return [RMMesh meshWithVBO:[RMGLVBOObject objectWithVertexData:vb indexData:nil]];
}

- (void)reset
{
    _vertexArray = [NSMutableArray array];
    _vertexSet = [NSMutableSet set];
}

- (void)appendTriangle:(RMMeshTriangle3D*)triangle
{
    if (self.format & RMVBOVertexAttributeTypeNormal &&
        (triangle.a.normal == nil || triangle.b.normal == nil || triangle.c.normal == nil)) {
    
        RMMeshVertex3D* ma = triangle.a;
        RMMeshVertex3D* mb = triangle.b;
        RMMeshVertex3D* mc = triangle.c;
        
        _RMVector3 a = ma.position.vector;
        _RMVector3 b = mb.position.vector;
        _RMVector3 c = mc.position.vector;
    
        _RMVector3 p0 = RMSubVector3(b, a);
        _RMVector3 p1 = RMSubVector3(c, a);
        
        _RMVector3 normal = RMCrossVector3(p0, p1);
        normal = RMNormalizeVector3(normal);
        
        RMVector3* norm = [RMVector3 vectorWithRMVector:normal];
        
        if (ma.normal == nil)
        {
            ma = [RMMeshVertex3D vertexWithPosition:ma.position normal:norm color:ma.color uv0:ma.uv0 uv1:ma.uv1 uv2:ma.uv2 uv3:ma.uv3];
        }
        
        if (mb.normal == nil)
        {
            mb = [RMMeshVertex3D vertexWithPosition:mb.position normal:norm color:mb.color uv0:mb.uv0 uv1:mb.uv1 uv2:mb.uv2 uv3:mb.uv3];
        }
        
        if (mc.normal == nil)
        {
            mc = [RMMeshVertex3D vertexWithPosition:mc.position normal:norm color:mc.color uv0:mc.uv0 uv1:mc.uv1 uv2:mc.uv2 uv3:mc.uv3];
        }
       
        [self appendVertex:ma];
        [self appendVertex:mb];
        [self appendVertex:mc];
        
        return;
    }
    
    [self appendVertex:triangle.a];
    [self appendVertex:triangle.b];
    [self appendVertex:triangle.c];
    
}


- (void)appendQuad:(RMMeshQuad3D*)quad
{
    [self appendTriangle:[RMMeshTriangle3D triangleWithVertexA:quad.a b:quad.b c:quad.c]];
    [self appendTriangle:[RMMeshTriangle3D triangleWithVertexA:quad.c b:quad.d c:quad.a]];;
}




- (void)appendVertex:(RMMeshVertex3D*)vertex
{
    RMVector3* position = nil;
    if (self.format & RMVBOVertexAttributeTypePosition)
    {
        position = vertex.position;
        if (position == nil)
        {
            position = self.zeroVector3;
        }
    }
    
    RMVector3* normal = nil;
    if (self.format & RMVBOVertexAttributeTypeNormal)
    {
        normal = vertex.normal;
        if (normal == nil)
        {
            normal = self.zeroVector3;
        }
    }
    
    RMVector4* color = nil;
    if (self.format & RMVBOVertexAttributeTypeColor)
    {
        color = vertex.color;
        if (color == nil)
        {
            color = self.zeroVector4;
        }
    }
    
    
    RMVector2* uv0 = nil;
    if (self.format & RMVBOVertexAttributeTypeUV0)
    {
        uv0 = vertex.uv0;
        if (uv0 == nil)
        {
            uv0 = self.zeroVector2;
        }
    }
    
    RMVector2* uv1 = nil;
    if (self.format & RMVBOVertexAttributeTypeUV1)
    {
        uv1 = vertex.uv1;
        if (uv1 == nil)
        {
            uv1 = self.zeroVector2;
        }
    }
    
    RMVector2* uv2 = nil;
    if (self.format & RMVBOVertexAttributeTypeUV2)
    {
        uv2 = vertex.uv2;
        if (uv2 == nil)
        {
            uv2 = self.zeroVector2;
        }
    }
    
    RMVector2* uv3 = nil;
    if (self.format & RMVBOVertexAttributeTypeUV3)
    {
        uv3 = vertex.uv3;
        if (uv3 == nil)
        {
            uv3 = self.zeroVector2;
        }
    }
    
    RMMeshVertex3D* vert = [RMMeshVertex3D vertexWithPosition:position normal:normal color:color uv0:uv0 uv1:uv1 uv2:uv2 uv3:uv3];
    
    [self.vertexArray addObject:vert];
    [self.vertexSet addObject:vert];
}




- (NSArray<RMVBOVertexAttribute*>*)attributes
{
    if (_attributes)
    {
        return _attributes;
    }
    
    NSInteger offset = 0;
    NSMutableArray<RMVBOVertexAttribute*>* attrs = [NSMutableArray array];
    
    if (self.format & RMVBOVertexAttributeTypePosition)
    {
        [attrs addObject:[RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypePosition offset:offset*sizeof(float) size:RMVBOVertexAttributeSize_3]];
        offset += 3;
    }
    
    if (self.format & RMVBOVertexAttributeTypeNormal)
    {
        [attrs addObject:[RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypeNormal offset:offset*sizeof(float) size:RMVBOVertexAttributeSize_3]];
        offset += 3;
    }
    
    if (self.format & RMVBOVertexAttributeTypeColor)
    {
        [attrs addObject:[RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypeColor offset:offset*sizeof(float) size:RMVBOVertexAttributeSize_4]];
        offset += 4;
    }
    
    if (self.format & RMVBOVertexAttributeTypeUV0)
    {
        [attrs addObject:[RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypeUV0 offset:offset*sizeof(float) size:RMVBOVertexAttributeSize_2]];
        offset += 2;
    }
    
    if (self.format & RMVBOVertexAttributeTypeUV1)
    {
        [attrs addObject:[RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypeUV1 offset:offset*sizeof(float) size:RMVBOVertexAttributeSize_2]];
        offset += 2;
    }
    
    if (self.format & RMVBOVertexAttributeTypeUV2)
    {
        [attrs addObject:[RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypeUV2 offset:offset*sizeof(float) size:RMVBOVertexAttributeSize_2]];
        offset += 2;
    }
    
    if (self.format & RMVBOVertexAttributeTypeUV3)
    {
        [attrs addObject:[RMVBOVertexAttribute attributeWithType:RMVBOVertexAttributeTypeUV3 offset:offset*sizeof(float) size:RMVBOVertexAttributeSize_2]];
        offset += 2;
    }
    
    _attributes = [attrs copy];
    
    return _attributes;
}



@end
