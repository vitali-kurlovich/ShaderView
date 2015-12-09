//
//  RMGLSLTexture.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/17/15.
//
//

#import "RMTexture.h"

@import UIKit;

@implementation RMTexture

- (instancetype)init
{
    UIImage* img = nil;
    return [self initWithImage:img];
}

- (instancetype)initWithName:(NSString*)name image:(UIImage*)image
{
    if (image == nil)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _name = [name copy];
      
    }
    
    return self;
}

- (nullable instancetype)initWithImage:(nonnull UIImage*)image
{
    return [self initWithName:nil image:image];
}

+ (instancetype)textureNamed:(NSString*)name
{
    if (name.length > 0)
    {
        UIImage* image = [UIImage imageNamed:name];
        return [[[self class] alloc] initWithName:name image:image];
    }
    return nil;
}

- (void)bindTexture
{
   
}



@end
