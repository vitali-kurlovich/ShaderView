//
//  RMGLRenderVBO.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/8/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLVBORender.h"

#import "RMVBOBuffer.h"
#import "RMVBOVertexBuffer.h"
#import "RMVBOIndexBuffer.h"

#import "RMVBOObject.h"

@import OpenGLES;

@interface RMGLVBORender ()
{
    struct {
        unsigned int vertexBufferDidPrepare:1;
        unsigned int indexBufferDidPrepare:1;
        
        GLuint vertexBuffer;
        GLuint indexBuffer;
    } _glVbo;
    
    BOOL _needsToRefrashBuffer;
    
}
@end

@implementation RMGLVBORender

- (void)setVbo:(RMVBOObject *)vbo
{
    if (super.vbo != vbo)
    {
        [self deleteBuffers];
        
        super.vbo = vbo;
        
        [self prepareBuffer];
    }
}

- (void)draw
{
    if (![self isPrepared]) return;
    [self refrashBuffers];
    [self bindBuffer];
    
    GLenum prim = [self glPrimitiveForVertexBufferPrimitive:self.vbo.vertexBuffer.primitive];
    
    RMVBOIndexBuffer* indexBuffer = self.vbo.indexBuffer;
    
    if (indexBuffer) {
        NSUInteger bytes = indexBuffer.dataSize/indexBuffer.count;
        GLenum type;
        
        if (bytes == 1)
        {
            type = GL_UNSIGNED_BYTE;
        } else if (bytes == 2)
        {
            type = GL_UNSIGNED_SHORT;
        } else {
            type = GL_UNSIGNED_INT;
        }
        
        glDrawElements(prim, (GLsizei)indexBuffer.count, type, 0);
    } else {
        glDrawArrays(prim, 0, (GLsizei)self.vbo.vertexBuffer.count);
    }
}

- (GLenum)glPrimitiveForVertexBufferPrimitive:(RMVBOVertexBufferPrimitive)primitive
{
    GLenum prim;
    switch (primitive) {
        case RMVBOVertexBufferPrimitiveTriangleStrip:
            prim = GL_TRIANGLE_STRIP;
            break;
        case RMVBOVertexBufferPrimitiveTriangleFan:
            prim = GL_TRIANGLE_FAN;
            break;
            
        case RMVBOVertexBufferPrimitiveLines:
            prim = GL_LINES;
            break;
            
        case RMVBOVertexBufferPrimitiveTriangle:
        default:
            prim = GL_TRIANGLES;
            break;
    }
    
    return prim;
}




- (BOOL)isPrepared
{
    
    if (self.vbo.indexBuffer)
    {
        return _glVbo.vertexBufferDidPrepare &&  _glVbo.indexBufferDidPrepare;
    }
    
    return _glVbo.vertexBufferDidPrepare;
}


- (BOOL)prepareBuffer
{
    if ([self isPrepared]) return YES;
    
    RMVBOIndexBuffer* indexBuffer = self.vbo.indexBuffer;
    RMVBOVertexBuffer* vertexBuffer = self.vbo.vertexBuffer;
    
    if (!_glVbo.vertexBufferDidPrepare && vertexBuffer) {
        glGenBuffers(1, &_glVbo.vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _glVbo.vertexBuffer);
        
        glBufferData(GL_ARRAY_BUFFER, vertexBuffer.dataSize, vertexBuffer.buffer, [self glEnumForBufferType:vertexBuffer.type]);
        _glVbo.vertexBufferDidPrepare = 1;
    }
    
    if (indexBuffer == nil)
    {
        return _glVbo.vertexBufferDidPrepare;
    }
    
    if (!_glVbo.indexBufferDidPrepare && indexBuffer) {
        glGenBuffers(1, &_glVbo.indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _glVbo.indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexBuffer.dataSize, indexBuffer.buffer, [self glEnumForBufferType:indexBuffer.type]);
        _glVbo.indexBufferDidPrepare = 1;
    }
    
    return _glVbo.vertexBufferDidPrepare && _glVbo.indexBufferDidPrepare;
}

- (void)bindBuffer
{
    if ([self isPrepared])
    {
        glBindBuffer(GL_ARRAY_BUFFER, _glVbo.vertexBuffer);
        
        if (self.vbo.indexBuffer)
        {
            glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _glVbo.indexBuffer);
        }
    }
}


- (void)setNeedsToRefrashBuffers
{
    _needsToRefrashBuffer = YES;
}


- (void)refrashBuffers
{
    if (![self isPrepared] || !_needsToRefrashBuffer) return;
    
    if (_glVbo.vertexBufferDidPrepare && self.vbo.vertexBuffer.type != RMVBODataBufferTypeStatic) {
        glBindBuffer(GL_ARRAY_BUFFER, _glVbo.vertexBuffer);
        glBufferSubData(GL_ARRAY_BUFFER, 0, self.vbo.vertexBuffer.dataSize, self.vbo.vertexBuffer.buffer);
    }
    
    if (self.vbo.indexBuffer && _glVbo.indexBufferDidPrepare && self.vbo.indexBuffer.type != RMVBODataBufferTypeStatic) {
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _glVbo.indexBuffer);
        glBufferSubData(GL_ELEMENT_ARRAY_BUFFER, 0, self.vbo.indexBuffer.dataSize, self.vbo.indexBuffer.buffer);
    }
    
    _needsToRefrashBuffer = NO;
}


- (void)deleteBuffers
{
    if (_glVbo.vertexBufferDidPrepare)
    {
        glDeleteBuffers(1, &_glVbo.vertexBuffer);
        _glVbo.vertexBufferDidPrepare = 0;
    }
    
    if (_glVbo.indexBufferDidPrepare)
    {
        glDeleteBuffers(1, &_glVbo.indexBuffer);
        _glVbo.indexBufferDidPrepare = 0;
    }
}

- (void)dealloc
{
    [self deleteBuffers];
}


- (GLenum)glEnumForBufferType:(RMVBODataBufferType)type
{
    GLenum glFlag;
    switch (type) {
        case RMVBODataBufferTypeStream:
            glFlag = GL_STREAM_DRAW;
            break;
            
        case RMVBODataBufferTypeDynamic:
            glFlag = GL_DYNAMIC_DRAW;
            break;
            
        case RMVBODataBufferTypeStatic:
        default:
            
            glFlag = GL_STATIC_DRAW;
            break;
    }
    
    return glFlag;
    
}




@end
