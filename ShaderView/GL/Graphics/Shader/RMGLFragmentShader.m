//
//  RMGLFragmentShader.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/23/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLFragmentShader.h"



@interface RMGLFragmentShader ()
{
    BOOL _compiled;
}
@end

@implementation RMGLFragmentShader

- (BOOL)isCompiled
{
    return _compiled;
}

- (BOOL)compile
{
    if ([self isCompiled])
    {
        return YES;
    }
    
    _shader = glCreateShader(GL_FRAGMENT_SHADER);
    
    const char * shaderStringUTF8 = [self.source UTF8String];
    int shaderStringLength = (int)[self.source length];
    
    glShaderSource(_shader, 1, &shaderStringUTF8, &shaderStringLength);
    glCompileShader(_shader);
    
    
    GLint compileSuccess;
    glGetShaderiv(_shader, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        glGetShaderInfoLog(_shader, sizeof(messages), 0, &messages[0]);
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"%@", messageString);
        _compiled = NO;
        return NO;
    }
    _compiled = YES;
    return YES;
}

@end
