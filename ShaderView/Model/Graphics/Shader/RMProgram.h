//
//  RMProgram.h
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

@import Foundation;

#import "RMVector.h"

@class RMVertexShader, RMFragmentShader, RMVertexAttribute, RMVBOVertexDataBuffer;
@class RMMatrix, RMMatrix2x2, RMMatrix3x3,RMMatrix4x4;
@class RMTexture;
@class UIColor;

@interface RMProgram : NSObject
@property (nullable, nonatomic, copy) NSString* name;


@property (nonatomic, getter=isCompiled) BOOL compiled;

@property (nonnull, nonatomic, readonly) RMVertexShader* vertexShader;
@property (nonnull, nonatomic, readonly) RMFragmentShader* fragmentShader;

- (nullable instancetype)initWithVertexShader:(nonnull RMVertexShader*)vertexShader fragmentShader:(nonnull RMFragmentShader*)fragmentShader ;
- (nullable instancetype)initWithName:(nullable NSString*)name vertexShader:(nonnull RMVertexShader*)vertexShader fragmentShader:(nonnull RMFragmentShader*)fragmentShader NS_DESIGNATED_INITIALIZER;


+ (nullable instancetype)programNamed:(nonnull NSString*)name;

- (BOOL)compile;
- (BOOL)useProgram;

- (void)prepareForUseVBOBuffer:(nonnull RMVBOVertexDataBuffer*)buffer;

- (void)setParam:(nonnull NSString*)name  matrix:(nullable RMMatrix*)matrix;
- (void)setParam:(nonnull NSString*)name texture:(nullable RMTexture*)texture;
- (void)setParam:(nonnull NSString*)name color:(nullable UIColor*)color;
- (void)setParam:(nonnull NSString*)name number:(nullable NSNumber*)number;



- (void)enableVertexAttribute:(nonnull RMVertexAttribute*)attr numberOfComponents:(NSInteger)numberOfComponents stride:(NSInteger)stride offset:(NSInteger)offset;
- (void)disableVertexAttribute:(nonnull RMVertexAttribute*)attr;


- (void)applyMatrix2x2:(nonnull RMMatrix2x2*)matrix name:(nonnull NSString*)name;
- (void)applyMatrix3x3:(nonnull RMMatrix3x3*)matrix name:(nonnull NSString*)name;
- (void)applyMatrix4x4:(nonnull RMMatrix4x4*)matrix name:(nonnull NSString*)name;

- (void)applyTexture:(nonnull RMTexture*)texture name:(nonnull NSString*)name index:(NSInteger)index;
- (void)applyColor:(nonnull UIColor*)color name:(nonnull NSString*)name;
- (void)applyNumber:(nonnull NSNumber*)number name:(nonnull NSString*)name;


@end
