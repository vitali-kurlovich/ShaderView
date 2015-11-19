//
//  RMGLSLTexture.h
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/17/15.
//
//

@import Foundation;


typedef NS_ENUM(NSInteger, RMTextureParams) {
    RMTextureParamsMagFilter,
    RMTextureParamsMinFilter,
    RMTextureParamsWrapS,
    RMTextureParamsWrapT
};

typedef NS_ENUM(NSInteger, RMTextureFilter) {
    RMTextureFilterNearest,
    RMTextureFilterLinear,
};

@class UIImage;

@interface RMTexture : NSObject

@property (nullable, nonatomic, copy, readonly) NSString* name;

@property (nonatomic) RMTextureParams params;
@property (nonatomic) RMTextureFilter filter;


- (nullable instancetype)initWithName:(nullable NSString*)name image:(nonnull UIImage*)image NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithImage:(nonnull UIImage*)image;

+ (nullable instancetype)textureNamed:(nonnull NSString*)name;

- (void)bindTexture;

@end
