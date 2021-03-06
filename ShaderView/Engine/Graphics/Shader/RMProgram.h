//
//  RMProgram.h
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

@import Foundation;

#import "RMVector.h"

@class RMVertexShader, RMFragmentShader, RMVertexAttribute, RMVBOVertexBuffer;
@class RMMatrix, RMMatrix2x2, RMMatrix3x3,RMMatrix4x4;
@class RMTexture;
@class UIColor;


typedef NS_ENUM(NSInteger,  RMShaderProgramMatrix ) {
    RMShaderProgramMatrixModelWord,
    
    //ModelViewMatrixInverseTranspose
};


@interface RMProgram : NSObject
@property (nullable, nonatomic, copy) NSString* name;


@property (nonatomic, getter=isCompiled) BOOL compiled;
@property (nonnull, nonatomic, copy, readonly) NSArray<RMVertexAttribute*>* attributes;
@property (nonnull, nonatomic, readonly) RMVertexShader* vertexShader;
@property (nonnull, nonatomic, readonly) RMFragmentShader* fragmentShader;

@property (nonatomic, readonly, getter=isActive) BOOL active;

- (nullable instancetype)initWithVertexShader:(nonnull NSString*)vertexShaderSocreCode
                               fragmentShader:(nonnull NSString*)fragmentShaderSocreCode
                                   attributes:(nonnull NSArray<RMVertexAttribute*>*)attributes;

- (nullable instancetype)initWithName:(nullable NSString*)name
                         vertexShader:(nonnull NSString*)vertexShaderSocreCode
                       fragmentShader:(nonnull NSString*)fragmentShaderSocreCode
                           attributes:(nonnull NSArray<RMVertexAttribute*>*)attributes NS_DESIGNATED_INITIALIZER;


+ (nullable instancetype)programNamed:(nonnull NSString*)name attributes:(nonnull NSArray<RMVertexAttribute*>*)attributes;

- (BOOL)compile;
- (BOOL)useProgramBegin;
- (void)useProgramEnd;

- (nullable RMVertexShader*)createVertexShader:(nonnull NSString*)src;
- (nullable RMFragmentShader*)creatFragmentShader:(nonnull NSString*)src;

- (void)prepareForUseVBOBuffer:(nonnull RMVBOVertexBuffer*)buffer;

- (void)setParam:(nonnull NSString*)name matrix:(nullable RMMatrix*)matrix;
- (void)setParam:(nonnull NSString*)name texture:(nullable RMTexture*)texture;
- (void)setParam:(nonnull NSString*)name color:(nullable UIColor*)color;

- (void)setParam:(nonnull NSString*)name floatValue:(float)value;
- (void)setParam:(nonnull NSString*)name intValue:(int)value;

- (void)setParam:(nonnull NSString*)name vector2:(nonnull RMVector2*)vector;
- (void)setParam:(nonnull NSString*)name vector3:(nonnull RMVector3*)vector;
- (void)setParam:(nonnull NSString*)name vector4:(nonnull RMVector4*)vector;


- (void)setParam:(nonnull NSString*)name number:(nullable NSNumber*)number;

- (void)enableVertexAttribute:(nonnull RMVertexAttribute*)attr numberOfComponents:(NSInteger)numberOfComponents stride:(NSInteger)stride offset:(NSInteger)offset;
- (void)disableVertexAttribute:(nonnull RMVertexAttribute*)attr;


- (void)applyFloatValue:(float)value name:(nonnull NSString*)name;
- (void)applyIntValue:(float)value name:(nonnull NSString*)name;

- (void)applyVector2:(nonnull RMVector2*)vector name:(nonnull NSString*)name;
- (void)applyVector3:(nonnull RMVector3*)vector name:(nonnull NSString*)name;
- (void)applyVector4:(nonnull RMVector4*)vector name:(nonnull NSString*)name;

- (void)applyMatrix2x2:(nonnull RMMatrix2x2*)matrix name:(nonnull NSString*)name;
- (void)applyMatrix3x3:(nonnull RMMatrix3x3*)matrix name:(nonnull NSString*)name;
- (void)applyMatrix4x4:(nonnull RMMatrix4x4*)matrix name:(nonnull NSString*)name;

- (void)applyTexture:(nonnull RMTexture*)texture name:(nonnull NSString*)name textureUnit:(NSUInteger)unit;

- (void)applyNumber:(nonnull NSNumber*)number name:(nonnull NSString*)name;


@end

@interface RMProgram (UIKit)
- (void)applyColor:(nonnull UIColor*)color name:(nonnull NSString*)name;
@end