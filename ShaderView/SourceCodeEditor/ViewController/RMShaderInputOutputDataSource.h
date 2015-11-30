//
//  RMShaderInputOutputDataSource.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSInteger, RMShaderIOType) {
    RMShaderIOTypeBool,
    RMShaderIOTypeFloat,
    RMShaderIOTypeInt,
    
    RMShaderIOTypeVec2,
    RMShaderIOTypeVec3,
    RMShaderIOTypeVec4,
    
    RMShaderIOTypeVec2b,
    RMShaderIOTypeVec3b,
    RMShaderIOTypeVec4b,
    
    RMShaderIOTypeVec2i,
    RMShaderIOTypeVec3i,
    RMShaderIOTypeVec4i,
    
    RMShaderIOTypeMat2,
    RMShaderIOTypeMat3,
    RMShaderIOTypeMat4,
    
    RMShaderIOTypeSampler1D,
    RMShaderIOTypeSampler2D,
    RMShaderIOTypeSampler3D,
};


typedef NS_ENUM(NSInteger, RMShaderIOPrecision) {
    RMShaderIOPrecisionHighp,
    RMShaderIOPrecisionMediump,
    RMShaderIOPrecisionLowp
};

/*
 
 Precision
 
 highp
 mediump
 lowp
 
 */

/*
 
 int a signed integer
 float a single floating-point scalar
 vec2 a two component floating-point vector
 vec3 a three component floating-point vector
 vec4 a four component floating-point vector
 bvec2 a two component Boolean vector
 bvec3 a three component Boolean vector
 bvec4 a four component Boolean vector
 ivec2 a two component integer vector
 ivec3 a three component integer vector
 ivec4 a four component integer vector
 mat2 a 2×2 floating-point matrix
 mat3 a 3×3 floating-point matrix
 mat4 a 4×4 floating-point matrix
 sampler2D a handle for accessing a 2D texture
 samplerCube
 
 */


@interface  RMShaderIODataSourceItem : NSObject

@property (nonnull, nonatomic, copy, readonly) NSString* name;
@property (nonatomic, readonly) NSInteger type;
@property (nonatomic, readonly) NSInteger precision;

@end

@interface RMShaderInputOutputDataSource : NSObject

@end
