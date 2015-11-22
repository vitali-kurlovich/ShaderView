//
//  RMGLSLProgram.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/17/15.
//
//

#import "RMGLSLProgram.h"

@import UIKit;
@import OpenGLES;

#import "RMVertexShader.h"
#import "RMFragmentShader.h"
#import "RMTexture.h"

#import "RMMatrix+_RMOpenGL_.h"
#import "RMMatrix4x4.h"

#import "RMVertexAttribute.h"

@interface RMGLSLProgram ()
{
    struct {
        
        GLuint vertex;
        GLuint fragment;
        GLuint program;
        
    } _handle;
    
    BOOL _vsCompiled;
    BOOL _fsCompiled;
    BOOL _programCompiled;
}

@end

@implementation RMGLSLProgram

 - (GLuint)program
{
    return _handle.program;
}

- (BOOL)isCompiled
{
    return _vsCompiled && _fsCompiled && _programCompiled;
}

- (BOOL)useProgram
{
    if ([self compile])
    {
       glUseProgram(_handle.program);
        return [super useProgram];
    }
    
    return NO;
}


- (void)enableVertexAttribute:(nonnull RMVertexAttribute*)attr numberOfComponents:(NSInteger)numberOfComponents stride:(NSInteger)stride offset:(NSInteger)offset
{
    GLint attrSlot = glGetAttribLocation(_handle.program, [attr.name UTF8String]);
    glEnableVertexAttribArray(attrSlot);
    GLchar* pointer = 0;
    glVertexAttribPointer(attrSlot, numberOfComponents, GL_FLOAT, GL_FALSE, stride, pointer+offset);
}

- (void)disableVertexAttribute:(nonnull RMVertexAttribute*)attr
{
    GLint attrSlot = glGetAttribLocation(_handle.program, [attr.name UTF8String]);
    glDisableVertexAttribArray(attrSlot);
    
}

- (void)applyMatrix2x2:(RMMatrix2x2*)matrix name:(NSString*)name
{
    
}

- (void)applyMatrix3x3:(RMMatrix3x3*)matrix name:(NSString*)name
{
    
}

- (void)applyMatrix4x4:(RMMatrix4x4*)matrix name:(NSString*)name
{
    int m4x4Uniform = glGetUniformLocation(_handle.program, [name UTF8String]);
    
     glUniformMatrix4fv(m4x4Uniform, 1, 0, [matrix glMatrix]);
}

- (void)applyTexture:(RMTexture*)texture name:(NSString*)name index:(NSInteger)index
{
    static GLenum const gl_texture[] = {GL_TEXTURE0, GL_TEXTURE1, GL_TEXTURE2, GL_TEXTURE3, GL_TEXTURE4, GL_TEXTURE5, GL_TEXTURE6, GL_TEXTURE7, GL_TEXTURE8, GL_TEXTURE9, GL_TEXTURE10, GL_TEXTURE11, GL_TEXTURE12, GL_TEXTURE13, GL_TEXTURE14, GL_TEXTURE15, GL_TEXTURE16, GL_TEXTURE17, GL_TEXTURE18, GL_TEXTURE19, GL_TEXTURE20, GL_TEXTURE21, GL_TEXTURE22, GL_TEXTURE23, GL_TEXTURE24, GL_TEXTURE25, GL_TEXTURE26, GL_TEXTURE27, GL_TEXTURE28, GL_TEXTURE29, GL_TEXTURE30, GL_TEXTURE31};
    
    glActiveTexture(gl_texture[index]);
    [texture bindTexture];
    
    int textureUniform = glGetUniformLocation(_handle.program, [name UTF8String]);
    glUniform1i(textureUniform, 0);
}

- (void)applyColor:(UIColor*)color name:(NSString*)name
{
    int colorUniform = glGetUniformLocation(_handle.program, [name UTF8String]);
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    glUniform4f(colorUniform, r, g, b, a);
}

- (void)applyNumber:(nonnull NSNumber*)number name:(nonnull NSString*)name
{
    int numberUniform = glGetUniformLocation(_handle.program, [name UTF8String]);
    glUniform1f(numberUniform, [number floatValue]);
}

- (BOOL)compile
{
    if (!_vsCompiled)
    {
        _vsCompiled = [self compileVertexShader:self.vertexShader.source];
    }
    
    if (!_fsCompiled)
    {
        _fsCompiled = [self compileFragmentShader:self.fragmentShader.source];
    }
    
    if (_fsCompiled && _vsCompiled && !_programCompiled)
    {
        _handle.program = glCreateProgram();
        glAttachShader(_handle.program, _handle.vertex);
        glAttachShader(_handle.program, _handle.fragment);
        glLinkProgram(_handle.program);
        
        GLint linkSuccess;
        glGetProgramiv(_handle.program, GL_LINK_STATUS, &linkSuccess);
        if (linkSuccess == GL_FALSE) {
            GLchar messages[256];
            glGetProgramInfoLog(_handle.program, sizeof(messages), 0, &messages[0]);
            NSString *messageString = [NSString stringWithUTF8String:messages];
            NSLog(@"%@", messageString);
            _programCompiled = NO;
        }
        _programCompiled = YES;
    }
    
    return _vsCompiled && _fsCompiled && _programCompiled;
}

- (BOOL)compileVertexShader:(NSString*)src  {
    
    _handle.vertex = glCreateShader(GL_VERTEX_SHADER);
    
    const char * shaderStringUTF8 = [src UTF8String];
    int shaderStringLength = (int)[src length];
    
    glShaderSource(_handle.vertex, 1, &shaderStringUTF8, &shaderStringLength);
    glCompileShader(_handle.vertex);
    
    
    GLint compileSuccess;
    glGetShaderiv(_handle.vertex, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(_handle.vertex, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        return NO;
    }
    
    return YES;
}

- (BOOL)compileFragmentShader:(NSString*)src  {
    
    _handle.fragment = glCreateShader(GL_FRAGMENT_SHADER);
    
    const char * shaderStringUTF8 = [src UTF8String];
    int shaderStringLength = (int)[src length];
    
    glShaderSource(_handle.fragment, 1, &shaderStringUTF8, &shaderStringLength);
    glCompileShader(_handle.fragment);
    
    
    GLint compileSuccess;
    glGetShaderiv(_handle.fragment, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(_handle.fragment, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        return NO;
    }
    
    return YES;
}


@end
