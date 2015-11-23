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
@property (nonatomic, readonly, getter=isCompiled) BOOL compiled;

- (nullable instancetype)initWithType:(RMShaderType)type source:(nonnull NSString*)source NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithSource:(nonnull NSString*)source;

+ (nullable instancetype)shader:(nonnull NSString*)source;

- (BOOL)compile;


@end






