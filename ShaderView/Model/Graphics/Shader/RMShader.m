//
//  RMShader.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

#import "RMVertexShader.h"
#import "RMFragmentShader.h"

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

- (nullable instancetype)initWithSource:(nonnull NSString*)source
{
    return  [self initWithType:RMShaderTypeNone source:source];
}


+ (nullable instancetype)shader:(nonnull NSString*)source
{
    return [[[self class] alloc] initWithSource:source];
}

@end
