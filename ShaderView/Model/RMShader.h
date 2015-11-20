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

@class RMVertexAttribute;

@interface RMShader : NSObject

@property (nonatomic, readonly) RMShaderType type;
@property (nonnull, nonatomic, copy, readonly) NSString* source;

- (nullable instancetype)initWithType:(RMShaderType)type source:(nonnull NSString*)source NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithSource:(nonnull NSString*)source;

+ (nullable instancetype)shader:(nonnull NSString*)source;

@end


@interface RMVertexShader : RMShader

@property (nullable, nonatomic, copy, readonly) NSArray<RMVertexAttribute*>* attributes;

- (nullable instancetype)initWithSource:(nonnull NSString*)source attributes:( nullable NSArray<RMVertexAttribute*>*)attributes;

+ (nullable instancetype)shader:(nonnull NSString*)source attributes:(nullable NSArray<RMVertexAttribute*>*)attributes;

@end

@interface RMFragmentShader : RMShader

@end


@interface RMVertexAttribute:NSObject
@property (nonnull, nonatomic, copy, readonly) NSString* name;


@end