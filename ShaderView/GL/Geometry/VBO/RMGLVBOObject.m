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
}
@end


@implementation RMGLVBOObject


- (BOOL)isPrepared
{
    return _vbo.vertexBufferDidPrepare && _vbo.indexBufferDidPrepare;
}

- (BOOL)prepareBuffer
{
 
    GLenum glFlag;
    // Posible this code must be in RMVBOBuffer
    switch (self.drawType) {
        case RMVBOObjectDrawTypeStream:
            glFlag = GL_STREAM_DRAW;
            break;
            
        case RMVBOObjectDrawTypeDynamic:
            glFlag = GL_DYNAMIC_DRAW;
            break;
            
        case RMVBOObjectDrawTypeStatic:
        default:
            
            glFlag = GL_STATIC_DRAW;
            break;
    }
    
    if (!_vbo.vertexBufferDidPrepare) {
        glGenBuffers(1, &_vbo.vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vbo.vertexBuffer);
        
        glBufferData(GL_ARRAY_BUFFER, self.vertexData.dataSize, self.vertexData.buffer, glFlag);
        _vbo.vertexBufferDidPrepare = 1;
    }
    
    if (!_vbo.indexBufferDidPrepare) {
        glGenBuffers(1, &_vbo.indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _vbo.indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, self.indexData.dataSize, self.indexData.buffer, glFlag);
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

@end


@implementation RMGLVBOObject (RMDrawable)

- (void)draw
{
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