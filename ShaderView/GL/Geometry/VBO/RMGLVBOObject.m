//
//  RMGLVBOObject.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLVBOObject.h"
#import "RMVBOBuffer.h"
#import "RMVBOVertexBuffer.h"

#import "RMVBOObject+RMDrawable.h"

@import OpenGLES;

@interface RMGLVBOObject ()
{
    struct {
        unsigned int vertexBufferDidPrepare:1;
        unsigned int indexBufferDidPrepare:1;
        
        GLuint vertexBuffer;
        GLuint indexBuffer;
    } _vbo;
    
    BOOL _needsToRefrashBuffer;
}
@end


@implementation RMGLVBOObject


- (BOOL)isPrepared
{
    if (self.indexBuffer)
    {
        return _vbo.vertexBufferDidPrepare &&  _vbo.indexBufferDidPrepare;
    }
    
    return _vbo.vertexBufferDidPrepare;
}


- (BOOL)prepareBuffer
{
    if ([self isPrepared]) return YES;
    
    if (!_vbo.vertexBufferDidPrepare && self.vertexBuffer) {
        glGenBuffers(1, &_vbo.vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vbo.vertexBuffer);
        
        glBufferData(GL_ARRAY_BUFFER, self.vertexBuffer.dataSize, self.vertexBuffer.buffer, [self glEnumForBufferType:self.vertexBuffer.type]);
        _vbo.vertexBufferDidPrepare = 1;
    }
    
    if (self.indexBuffer == nil)
    {
        return _vbo.vertexBufferDidPrepare;
    }
    
    if (!_vbo.indexBufferDidPrepare && self.indexBuffer) {
        glGenBuffers(1, &_vbo.indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _vbo.indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, self.indexBuffer.dataSize, self.indexBuffer.buffer, [self glEnumForBufferType:self.indexBuffer.type]);
        _vbo.indexBufferDidPrepare = 1;
    }
    
    return _vbo.vertexBufferDidPrepare && _vbo.indexBufferDidPrepare;
}

- (void)bindBuffer
{
    if ([self isPrepared])
    {
        glBindBuffer(GL_ARRAY_BUFFER, _vbo.vertexBuffer);
        if (self.indexBuffer)
        {
            glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _vbo.indexBuffer);
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
    
    if (_vbo.vertexBufferDidPrepare && self.vertexBuffer.type != RMVBODataBufferTypeStatic) {
        glBindBuffer(GL_ARRAY_BUFFER, _vbo.vertexBuffer);
        glBufferSubData(GL_ARRAY_BUFFER, 0, self.vertexBuffer.dataSize, self.vertexBuffer.buffer);
    }
    
    if (self.indexBuffer && _vbo.indexBufferDidPrepare && self.indexBuffer.type != RMVBODataBufferTypeStatic) {
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _vbo.indexBuffer);
        glBufferSubData(GL_ELEMENT_ARRAY_BUFFER, 0, self.indexBuffer.dataSize, self.indexBuffer.buffer);
    }
    
    _needsToRefrashBuffer = NO;
}


- (void)dealloc
{
    if (_vbo.vertexBufferDidPrepare)
    {
        glDeleteBuffers(1, &_vbo.vertexBuffer);
    }
    
    if (_vbo.indexBufferDidPrepare)
    {
        glDeleteBuffers(1, &_vbo.indexBuffer);
    }
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


@implementation RMGLVBOObject (RMDrawable)

- (void)draw
{
    if (![self isPrepared]) return;
    
    [self refrashBuffers];
    [self bindBuffer];
    
    GLenum prim = [self glPrimitiveForVertexBufferPrimitive:self.vertexBuffer.primitive];
    
    if (self.indexBuffer) {
        int bytes = self.indexBuffer.dataSize/self.indexBuffer.count;
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
        
        glDrawElements(prim, self.indexBuffer.count, type, 0);
    } else {
        glDrawArrays(prim, 0, self.vertexBuffer.count);
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
            
        case RMVBOVertexBufferPrimitiveTriangle:
        default:
            prim = GL_TRIANGLES;
            break;
    }
    
    return prim;
}

@end