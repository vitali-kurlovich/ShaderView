//
//  RMShader.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

#import "RMShader.h"

@implementation RMShader

- (instancetype)init
{
    return [self initWithType:RMShaderTypeNone source:@""];
}


- (nullable instancetype)initWithType:(RMShaderType)type source:(nonnull NSString*)source
{
    if ((RMShaderTypeVertex == type || RMShaderTypeFragment == type) && source.length > 0)
    {
        self = [super init];
        
        if (self)
        {
            _source = [source copy];
            _type = type;
        }
        return self;
    }
    
    return nil;
}

+ (nullable instancetype)vertexShader:(nonnull NSString*)source
{
    return [[[self class] alloc] initWithType:RMShaderTypeVertex source:source];
}

+ (nullable instancetype)fragmentShader:(nonnull NSString*)source
{
    return [[[self class] alloc] initWithType:RMShaderTypeFragment source:source];
}

+ (nullable instancetype)shader:(nonnull NSString*)source
{
    return [[[self class] alloc] initWithType:RMShaderTypeNone source:source];
}

@end

@implementation RMVertexShader : RMShader

+ (nullable instancetype)shader:(nonnull NSString*)source
{
    return [[[self class] alloc] initWithType:RMShaderTypeVertex source:source];
}

@end

@implementation RMFragmentShader : RMShader

+ (nullable instancetype)shader:(nonnull NSString*)source
{
    return [[[self class] alloc] initWithType:RMShaderTypeFragment source:source];
}
@end