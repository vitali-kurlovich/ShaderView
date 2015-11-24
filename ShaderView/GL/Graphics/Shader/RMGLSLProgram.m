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

#import "RMGLVertexShader.h"
#import "RMGLFragmentShader.h"
#import "RMTexture.h"

#import "RMMatrix+_RMOpenGL_.h"
#import "RMMatrix4x4.h"

#import "RMVertexAttribute.h"

@interface RMGLSLProgram ()
{
    BOOL _programCompiled;
}

@property (nonatomic, readonly) RMGLVertexShader* glVertexShader;
@property (nonatomic, readonly) RMGLFragmentShader* glFragmentShader;

@end

@implementation RMGLSLProgram

- (BOOL)isCompiled
{
    return  _programCompiled;
}

- (BOOL)useProgramBegin
{
    if ([self compile])
    {
        if ([self isActive])
        {
            return YES;
        }
        glUseProgram(_program);
        return [super useProgramBegin];
    }
    
    return NO;
}

- (void)useProgramEnd
{
    [super useProgramEnd];
}

- (RMGLVertexShader*)glVertexShader
{
    return (RMGLVertexShader*)self.vertexShader;
}

- (RMGLFragmentShader*)glFragmentShader
{
    return (RMGLFragmentShader*)self.fragmentShader;
}


- (nullable RMVertexShader*)createVertexShader:(nonnull NSString*)src
{
    return [RMGLVertexShader shader:src];
}

- (nullable RMFragmentShader*)creatFragmentShader:(nonnull NSString*)src
{
    return [RMGLFragmentShader shader:src];;
}


- (void)enableVertexAttribute:(nonnull RMVertexAttribute*)attr numberOfComponents:(NSInteger)numberOfComponents stride:(NSInteger)stride offset:(NSInteger)offset
{
    GLint attrSlot = glGetAttribLocation(_program, [attr.name UTF8String]);
    glEnableVertexAttribArray(attrSlot);
    GLchar* pointer = 0;
    glVertexAttribPointer(attrSlot, numberOfComponents, GL_FLOAT, GL_FALSE, stride, pointer+offset);
}

- (void)disableVertexAttribute:(nonnull RMVertexAttribute*)attr
{
    GLint attrSlot = glGetAttribLocation(_program, [attr.name UTF8String]);
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
    int m4x4Uniform = glGetUniformLocation(_program, [name UTF8String]);
    
    glUniformMatrix4fv(m4x4Uniform, 1, 0, [matrix glMatrix]);
}

- (void)applyTexture:(RMTexture*)texture name:(NSString*)name textureUnit:(NSUInteger)unit
{
    static GLenum const gl_texture[] = {GL_TEXTURE0, GL_TEXTURE1, GL_TEXTURE2, GL_TEXTURE3, GL_TEXTURE4, GL_TEXTURE5, GL_TEXTURE6, GL_TEXTURE7, GL_TEXTURE8, GL_TEXTURE9, GL_TEXTURE10, GL_TEXTURE11, GL_TEXTURE12, GL_TEXTURE13, GL_TEXTURE14, GL_TEXTURE15, GL_TEXTURE16, GL_TEXTURE17, GL_TEXTURE18, GL_TEXTURE19, GL_TEXTURE20, GL_TEXTURE21, GL_TEXTURE22, GL_TEXTURE23, GL_TEXTURE24, GL_TEXTURE25, GL_TEXTURE26, GL_TEXTURE27, GL_TEXTURE28, GL_TEXTURE29, GL_TEXTURE30, GL_TEXTURE31};
    
    int textureUniform = glGetUniformLocation(_program, [name UTF8String]);
    glUniform1i(textureUniform, unit);
    
    glActiveTexture(gl_texture[unit]);
    [texture bindTexture];
}

- (void)applyColor:(UIColor*)color name:(NSString*)name
{
    int colorUniform = glGetUniformLocation(_program, [name UTF8String]);
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    glUniform4f(colorUniform, r, g, b, a);
}

- (void)applyNumber:(nonnull NSNumber*)number name:(nonnull NSString*)name
{
    int numberUniform = glGetUniformLocation(_program, [name UTF8String]);
    glUniform1f(numberUniform, [number floatValue]);
}

- (BOOL)compile
{
    if ([self isCompiled])
    {
        return YES;
    }
    
    if (![self.glVertexShader isCompiled])
    {
        [self.glVertexShader compile];
    }
    
    if (![self.glFragmentShader isCompiled])
    {
        [self.glFragmentShader compile];
    }
    
    if ([self.glVertexShader isCompiled] && [self.glFragmentShader isCompiled])
    {
        _program = glCreateProgram();
        glAttachShader(_program, self.glVertexShader.shader);
        glAttachShader(_program, self.glFragmentShader.shader);
        glLinkProgram(_program);
        
        GLint linkSuccess;
        glGetProgramiv(_program, GL_LINK_STATUS, &linkSuccess);
        if (linkSuccess == GL_FALSE) {
            GLchar messages[256];
            glGetProgramInfoLog(_program, sizeof(messages), 0, &messages[0]);
            NSString *messageString = [NSString stringWithUTF8String:messages];
            NSLog(@"%@", messageString);
            _programCompiled = NO;
        }
        _programCompiled = YES;
    }
    
    return  _programCompiled;
}

@end
