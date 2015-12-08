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
#import "RMVBOIndexBuffer.h"

#import "RMGLVBOObject.h"

#import "RMMesh.h"

#import "RMMeshVertex3D.h"


@interface RMMeshBuilder ()

@property (nonatomic,  readonly) NSMutableArray<RMMeshVertex3D*>* vertexArray;

@property (nonatomic, readonly) BOOL optimized;
@property (nonatomic, readonly)  NSArray<RMMeshVertex3D*>* optVertexArray;
@property (nonatomic, readonly)  NSArray<NSNumber*>* optIndexArray;
@property (nonatomic, readonly)  NSInteger maxIndex;


@property (nonatomic, readonly) NSArray<RMMeshVertex3D*>* vertexData;
@property (nonatomic, readonly) NSArray<NSNumber*>* indexData;

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
        
        _format = format;
        
        _zeroVector2 = [RMVector2 vectorWithX:0 y:0];
        _zeroVector3 = [RMVector3 vectorWithX:0 y:0 z:0];
        _zeroVector4 = [RMVector4 vectorWithX:0 y:0 z:0 w:0];
        
        _useOptimization = YES;
        
    }
    return self;
}

- (NSArray<RMMeshVertex3D*>*)vertexData
{
    if (self.optimized)
    {
        return self.optVertexArray;
    }
    return self.vertexArray;
}


- ( NSArray<NSNumber*>*)indexData
{
    if (self.optimized)
    {
        return self.optIndexArray;
    }
    return nil;
}

- (void)buildOpt
{
    if (!self.optimized)
    {
        _optVertexArray = nil;
        _optIndexArray = nil;
        
        NSMutableArray<RMMeshVertex3D*>* vertArray = [NSMutableArray arrayWithCapacity:self.vertexArray.count];
        NSMutableArray<NSNumber*>* indexArray = [NSMutableArray arrayWithCapacity:self.vertexArray.count];
        
        NSMutableDictionary<RMMeshVertex3D*, NSNumber*>* cache = [NSMutableDictionary dictionaryWithCapacity:self.vertexArray.count];
        
        NSInteger currentIdx = 0;
        for (RMMeshVertex3D* vert in self.vertexArray)
        {
            NSNumber* index = cache[vert];
            
            if (index)
            {
                [indexArray addObject:index];
            } else {
                index = @(currentIdx);
                cache[vert] = index;
                
                [indexArray addObject:index];
                [vertArray addObject:vert];
                currentIdx++;
            }
        }
        
        _maxIndex = (currentIdx - 1);
        _optVertexArray = vertArray;
        _optIndexArray = indexArray;
        _optimized = YES;
    }
}


- (nonnull RMMesh*)build
{
    if (self.useOptimization)
    {
        [self buildOpt];
    }
    
    NSArray<RMVBOVertexAttribute*>* attributes = self.attributes;
    RMVBOVertexAttribute* last = [attributes lastObject];
    
    NSInteger patchSize = last.offset/sizeof(float) + last.size;
    
    NSArray<RMMeshVertex3D*>* vertexData = self.vertexData;
    
    NSInteger vertCount = vertexData.count;
    
    float vertexBuffer[vertCount*patchSize];
    
    for (RMVBOVertexAttribute* attr in attributes)
    {
        NSInteger offset = attr.offset/sizeof(float);
        
        if (attr.type == RMVBOVertexAttributeTypePosition) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in vertexData)
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
            for (RMMeshVertex3D* vert in vertexData)
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
            for (RMMeshVertex3D* vert in vertexData)
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
            for (RMMeshVertex3D* vert in vertexData)
            {
                vertexBuffer[index] = vert.uv0.vector.x;
                vertexBuffer[index + 1] = vert.uv0.vector.y;
                
                index += patchSize;
            }
            continue;
        }
        
        if (attr.type == RMVBOVertexAttributeTypeUV1) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in vertexData)
            {
                vertexBuffer[index] = vert.uv1.vector.x;
                vertexBuffer[index + 1] = vert.uv1.vector.y;
                
                index += patchSize;
            }
            continue;
        }
        
        if (attr.type == RMVBOVertexAttributeTypeUV2) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in vertexData)
            {
                vertexBuffer[index] = vert.uv2.vector.x;
                vertexBuffer[index + 1] = vert.uv2.vector.y;
                
                index += patchSize;
            }
            continue;
        }
        
        if (attr.type == RMVBOVertexAttributeTypeUV3) {
            NSInteger index = offset;
            for (RMMeshVertex3D* vert in vertexData)
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
    
    RMVBOIndexBuffer* ib = nil;
    
    if (self.indexData) {
        
        NSArray<NSNumber*>* indexData = self.indexData;
        
        if (self.maxIndex < 0xff)
        {
            uint8_t buffer[indexData.count];
            
            NSInteger idx = 0;
            for (NSNumber* number in indexData)
            {
                buffer[idx] = [number unsignedCharValue];
                idx++;
            }
            
            ib = [RMVBOIndexBuffer buffer:buffer count:indexData.count dataSize:indexData.count*sizeof(uint8_t)];
            
        } else if (self.maxIndex < 0xffff)
        {
            uint16_t buffer[indexData.count];
            
            NSInteger idx = 0;
            for (NSNumber* number in indexData)
            {
                buffer[idx] = [number unsignedShortValue];
                idx++;
            }
            
            ib = [RMVBOIndexBuffer buffer:buffer count:indexData.count dataSize:indexData.count*sizeof(uint16_t)];
            
        } else {
            uint32_t buffer[indexData.count];
            
            NSInteger idx = 0;
            for (NSNumber* number in indexData)
            {
                buffer[idx] = [number unsignedIntValue];
                idx++;
            }
            
            ib = [RMVBOIndexBuffer buffer:buffer count:indexData.count dataSize:indexData.count*sizeof(uint32_t)];
        }
        
    }
    
    return [RMMesh meshWithVBO:[RMGLVBOObject objectWithVertexData:vb indexData:ib]];
}

- (void)reset
{
    [_vertexArray removeAllObjects];
    
    _maxIndex = 0;
    _optVertexArray = nil;
    _optIndexArray = nil;
    _optimized = NO;
}

- (void)appendTriangle:(RMMeshTriangle3D*)triangle
{
    [self appendTriangleWithVertexA:triangle.a b:triangle.b c:triangle.c];
}


- (void)appendTriangleWithVertexA:(RMMeshVertex3D*)a b:(RMMeshVertex3D*)b c:(RMMeshVertex3D*)c
{
    if (self.format & RMVBOVertexAttributeTypeNormal &&
        (a.normal == nil || b.normal == nil || c.normal == nil)) {
        
        
        _RMVector3 va = a.position.vector;
        _RMVector3 vb = b.position.vector;
        _RMVector3 vc = c.position.vector;
        
        _RMVector3 p0 = RMSubVector3(vb, va);
        _RMVector3 p1 = RMSubVector3(vc, va);
        
        _RMVector3 normal = RMCrossVector3(p0, p1);
        normal = RMNormalizeVector3(normal);
        
        RMVector3* norm = [RMVector3 vectorWithRMVector:normal];
        
        if (a.normal == nil)
        {
            a = [RMMeshVertex3D vertexWithPosition:a.position normal:norm color:a.color uv0:a.uv0 uv1:a.uv1 uv2:a.uv2 uv3:a.uv3];
        }
        
        if (b.normal == nil)
        {
            b = [RMMeshVertex3D vertexWithPosition:b.position normal:norm color:b.color uv0:b.uv0 uv1:b.uv1 uv2:b.uv2 uv3:b.uv3];
        }
        
        if (c.normal == nil)
        {
            c = [RMMeshVertex3D vertexWithPosition:c.position normal:norm color:c.color uv0:c.uv0 uv1:c.uv1 uv2:c.uv2 uv3:c.uv3];
        }
    }
    
    [self appendVertex:a];
    [self appendVertex:b];
    [self appendVertex:c];
}


- (void)appendQuad:(RMMeshQuad3D*)quad
{
    [self appendQuadWithVertexA:quad.a b:quad.b c:quad.c d:quad.d];
}

- (void)appendQuadWithVertexA:(RMMeshVertex3D*)a b:(RMMeshVertex3D*)b c:(RMMeshVertex3D*)c d:(RMMeshVertex3D*)d;
{
    if ((self.format & RMVBOVertexAttributeTypeNormal) &&
        (a.normal == nil || b.normal == nil || c.normal == nil || d.normal == nil)) {
        
        _RMVector3 va = a.position.vector;
        _RMVector3 vb = b.position.vector;
        _RMVector3 vc = c.position.vector;
        _RMVector3 vd = d.position.vector;
        
        _RMVector3 p0 = RMSubVector3(vb, va);
        _RMVector3 p1 = RMSubVector3(vc, va);
        
        _RMVector3 normal = RMCrossVector3(p0, p1);
        
         p0 = RMSubVector3(vd, vc);
         p1 = RMSubVector3(va, vc);
        
        _RMVector3 normal2 = RMCrossVector3(p0, p1);
        
        normal = RMNormalizeVector3(RMSumVector3(normal, normal2));
        
        RMVector3* norm = [RMVector3 vectorWithRMVector:normal];
        
        if (a.normal == nil)
        {
            a = [RMMeshVertex3D vertexWithPosition:a.position normal:norm color:a.color uv0:a.uv0 uv1:a.uv1 uv2:a.uv2 uv3:a.uv3];
        }
        
        if (b.normal == nil)
        {
            b = [RMMeshVertex3D vertexWithPosition:b.position normal:norm color:b.color uv0:b.uv0 uv1:b.uv1 uv2:b.uv2 uv3:b.uv3];
        }
        
        if (c.normal == nil)
        {
            c = [RMMeshVertex3D vertexWithPosition:c.position normal:norm color:c.color uv0:c.uv0 uv1:c.uv1 uv2:c.uv2 uv3:c.uv3];
        }
        
        if (d.normal == nil)
        {
            d = [RMMeshVertex3D vertexWithPosition:d.position normal:norm color:d.color uv0:d.uv0 uv1:d.uv1 uv2:d.uv2 uv3:d.uv3];
        }
    }
    
    [self appendVertex:a];
    [self appendVertex:b];
    [self appendVertex:c];
    
    [self appendVertex:c];
    [self appendVertex:d];
    [self appendVertex:a];

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
    _optimized = NO;
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
    }
    
    _attributes = [attrs copy];
    
    return _attributes;
}



@end
