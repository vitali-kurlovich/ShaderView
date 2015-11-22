//
//  RMGLVBOObject.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLVBOObject.h"
#import "RMVBODataBuffer.h"

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
    if (!_vbo.vertexBufferDidPrepare) {
        glGenBuffers(1, &_vbo.vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vbo.vertexBuffer);
        
        glBufferData(GL_ARRAY_BUFFER, self.vertexData.dataSize, self.vertexData.buffer, GL_STATIC_DRAW);
        _vbo.vertexBufferDidPrepare = 1;
    }
    
    if (!_vbo.indexBufferDidPrepare) {
        glGenBuffers(1, &_vbo.indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _vbo.indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, self.indexData.dataSize, self.indexData.buffer, GL_STATIC_DRAW);
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
