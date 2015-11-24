//
//  RMGLVBOObject.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLVBOObject.h"
#import "RMVBODataBuffer.h"

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
    return _vbo.vertexBufferDidPrepare && _vbo.indexBufferDidPrepare;
}


- (BOOL)prepareBuffer
{
    if ([self isPrepared]) return YES;
    
    if (!_vbo.vertexBufferDidPrepare) {
        glGenBuffers(1, &_vbo.vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vbo.vertexBuffer);
        
        glBufferData(GL_ARRAY_BUFFER, self.vertexData.dataSize, self.vertexData.buffer, [self glEnumForBufferType:self.vertexData.type]);
        _vbo.vertexBufferDidPrepare = 1;
    }
    
    if (!_vbo.indexBufferDidPrepare) {
        glGenBuffers(1, &_vbo.indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _vbo.indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, self.indexData.dataSize, self.indexData.buffer, [self glEnumForBufferType:self.indexData.type]);
        _vbo.indexBufferDidPrepare = 1;
    }
    
    return _vbo.vertexBufferDidPrepare && _vbo.indexBufferDidPrepare;
}

- (void)bindBuffer
{
    if ([self isPrepared])
    {
        glBindBuffer(GL_ARRAY_BUFFER, _vbo.vertexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _vbo.indexBuffer);
    }
}


- (void)setNeedsToRefrashBuffer
{
    _needsToRefrashBuffer = YES;
}


- (void)refrashBuffers
{
    if (![self isPrepared] || !_needsToRefrashBuffer) return;
    
    if (_vbo.vertexBufferDidPrepare && self.vertexData.type != RMVBODataBufferTypeStatic) {
        glBindBuffer(GL_ARRAY_BUFFER, _vbo.vertexBuffer);
        glBufferSubData(GL_ARRAY_BUFFER, 0, self.vertexData.dataSize, self.vertexData.buffer);
    }
    
    if (_vbo.indexBufferDidPrepare && self.indexData.type != RMVBODataBufferTypeStatic) {
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _vbo.indexBuffer);
        glBufferSubData(GL_ELEMENT_ARRAY_BUFFER, 0, self.indexData.dataSize, self.indexData.buffer);
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
    
    [self refrashBuffers];
    [self bindBuffer];
    
    int bytes = self.indexData.dataSize/self.indexData.count;
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
    
    glDrawElements(GL_TRIANGLES, self.indexData.count, type, 0);
}

@end