//
//  RMGLTexture.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

#import "RMGLTexture.h"

@import UIKit;
@import OpenGLES;


@interface RMGLTexture ()
{
    struct {
        GLuint textureName;
    } _texture;
}

@end

@implementation RMGLTexture


- (instancetype)initWithName:(NSString*)name image:(UIImage*)image
{
    self = [super initWithName:name image:image];
    if (self)
    {
        [self bindImage:image];
    }
    return self;
}


- (void)bindTexture
{
    glBindTexture(GL_TEXTURE_2D, _texture.textureName);
}

- (void)bindImage:(UIImage*)image
{
    CGImageRef imageRef = image.CGImage;
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    GLubyte * texData = (GLubyte *) calloc(width*height*4, sizeof(GLubyte));
    
    CGContextRef context = CGBitmapContextCreate(texData, width, height, 8, width*4, CGImageGetColorSpace(imageRef), kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGContextRelease(context);
    
    glGenTextures(1, &_texture.textureName);
    glBindTexture(GL_TEXTURE_2D, _texture.textureName);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, texData);
    
    free(texData);
}

- (void)dealloc
{
    glDeleteTextures(1, &_texture.textureName);
}

@end
