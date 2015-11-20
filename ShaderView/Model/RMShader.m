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

- (nullable instancetype)initWithSource:(nonnull NSString*)source
{
    return  [self initWithType:RMShaderTypeNone source:source];
}


+ (nullable instancetype)shader:(nonnull NSString*)source
{
    return [[[self class] alloc] initWithSource:source];
}

@end



@implementation RMVertexShader : RMShader

- (nullable instancetype)initWithSource:(nonnull NSString*)source attributes:( nullable NSArray<RMVertexAttribute*>*)attributes
{
    self = [super initWithType:RMShaderTypeVertex source:source];
    
    if (self)
    {
        _attributes = [attributes copy];
    }
    return self;
}

- (nullable instancetype)initWithSource:(nonnull NSString*)source
{
    return [self initWithSource:source attributes:nil];
}

+ (nullable instancetype)shader:(nonnull NSString*)source attributes:(nullable NSArray<RMVertexAttribute*>*)attributes
{
    return [[[self class] alloc] initWithSource:source attributes:attributes];
}

@end

@implementation RMFragmentShader : RMShader

- (nullable instancetype)initWithSource:(nonnull NSString*)source
{
    self = [super initWithType:RMShaderTypeFragment source:source];
    return self;
}
@end