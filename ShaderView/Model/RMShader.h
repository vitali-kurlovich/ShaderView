//
//  RMShader.h
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

@import Foundation;

typedef  NS_ENUM(NSInteger, RMShaderType)
{
    RMShaderTypeNone = 0,
    RMShaderTypeVertex,
    RMShaderTypeFragment
};

@interface RMShader : NSObject

@property (nonatomic, readonly) RMShaderType type;
@property (nonnull, nonatomic, copy, readonly) NSString* source;

- (nullable instancetype)initWithType:(RMShaderType)type source:(nonnull NSString*)source NS_DESIGNATED_INITIALIZER;

+ (nullable instancetype)shader:(nonnull NSString*)source;

@end


@interface RMVertexShader : RMShader

@end

@interface RMFragmentShader : RMShader

@end