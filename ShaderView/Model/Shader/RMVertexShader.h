//
//  RMVertexShader.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMShader.h"

@class RMVertexAttribute;

@interface RMVertexShader : RMShader

@property (nullable, nonatomic, copy, readonly) NSArray<RMVertexAttribute*>* attributes;

- (nullable instancetype)initWithSource:(nonnull NSString*)source attributes:( nullable NSArray<RMVertexAttribute*>*)attributes;

+ (nullable instancetype)shader:(nonnull NSString*)source attributes:(nullable NSArray<RMVertexAttribute*>*)attributes;

@end

@interface RMVertexAttribute:NSObject
@property (nonnull, nonatomic, copy, readonly) NSString* name;
@end