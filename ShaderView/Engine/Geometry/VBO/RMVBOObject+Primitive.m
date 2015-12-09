//
//  RMVBOObject+Primitive.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBOObject+Primitive.h"

#import "RMVBOIndexBuffer.h"

@implementation RMVBOObject (Primitive)
- (instancetype)cloneVBOWithPrimitiveType:(RMVBOVertexBufferPrimitive)primitive
{
    if (self.vertexBuffer.primitive == primitive)
    {
        return self;
    }
    
    if (primitive == RMVBOVertexBufferPrimitiveLines)
    {
        return [self _cloneVBOWithToPrimitiveLines];
    }
    
    
    return nil;
}

- (instancetype)_cloneVBOWithToPrimitiveLines
{
    
    if (self.vertexBuffer.primitive == RMVBOVertexBufferPrimitiveTriangle)
    {
        RMVBOIndexBuffer* indexBuffer = self.indexBuffer;
        
        if (indexBuffer)
        {
            NSUInteger bytes = indexBuffer.dataSize/indexBuffer.count;
            
            NSUInteger dst_count = indexBuffer.count*2;
            NSUInteger src_count = indexBuffer.count;
            
            if (bytes == 1)
            {
                uint8_t dst_buffer[dst_count];
                
                uint8_t* src_buffer = (uint8_t *)indexBuffer.buffer;
                int dstIdx = 0;
                for (int idx = 0; idx < src_count; idx+=3)
                {
                    dst_buffer[dstIdx] = src_buffer[idx];
                    dst_buffer[dstIdx + 1] = src_buffer[idx + 1];
                    
                    dst_buffer[dstIdx + 2] = src_buffer[idx + 1];
                    dst_buffer[dstIdx + 3] = src_buffer[idx + 2];
                    
                    dst_buffer[dstIdx + 4] = src_buffer[idx + 2];
                    dst_buffer[dstIdx + 5] = src_buffer[idx];
                    
                    dstIdx+=6;
                }
                
                indexBuffer = [RMVBOIndexBuffer buffer:dst_buffer count:dst_count dataSize:dst_count*sizeof(uint8_t)];
            }
            else if (bytes == 2)
            {
                uint16_t dst_buffer[dst_count];
                
                uint16_t* src_buffer = (uint16_t *)indexBuffer.buffer;
                int dstIdx = 0;
                for (int idx = 0; idx < src_count; idx+=3)
                {
                    dst_buffer[dstIdx] = src_buffer[idx];
                    dst_buffer[dstIdx + 1] = src_buffer[idx + 1];
                    
                    dst_buffer[dstIdx + 2] = src_buffer[idx + 1];
                    dst_buffer[dstIdx + 3] = src_buffer[idx + 2];
                    
                    dst_buffer[dstIdx + 4] = src_buffer[idx + 2];
                    dst_buffer[dstIdx + 5] = src_buffer[idx];
                    
                    dstIdx+=6;
                }

                
                indexBuffer = [RMVBOIndexBuffer buffer:dst_buffer count:dst_count dataSize:dst_count*sizeof(uint16_t)];
            }
            else
            {
                uint32_t dst_buffer[dst_count];
                
                uint32_t* src_buffer = (uint32_t *)indexBuffer.buffer;
                int dstIdx = 0;
                for (int idx = 0; idx < src_count; idx+=3)
                {
                    dst_buffer[dstIdx] = src_buffer[idx];
                    dst_buffer[dstIdx + 1] = src_buffer[idx + 1];
                    
                    dst_buffer[dstIdx + 2] = src_buffer[idx + 1];
                    dst_buffer[dstIdx + 3] = src_buffer[idx + 2];
                    
                    dst_buffer[dstIdx + 4] = src_buffer[idx + 2];
                    dst_buffer[dstIdx + 5] = src_buffer[idx];
                    
                    dstIdx+=6;
                }

                indexBuffer = [RMVBOIndexBuffer buffer:dst_buffer count:dst_count dataSize:dst_count*sizeof(uint32_t)];
            }
        }
        
        RMVBOVertexBuffer* vertexBuffer = self.vertexBuffer;
        
        vertexBuffer = [RMVBOVertexBuffer buffer:vertexBuffer.buffer
                                            type:RMVBODataBufferTypeStatic
                                           count:vertexBuffer.count
                                        dataSize:vertexBuffer.dataSize
                                      attributes:vertexBuffer.attributes
                                       primitive:RMVBOVertexBufferPrimitiveLines];
        
        return [[self class] objectWithVertexData:vertexBuffer indexData:indexBuffer];
    }
    
    return nil;
}

@end
