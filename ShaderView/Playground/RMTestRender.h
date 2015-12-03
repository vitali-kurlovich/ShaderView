//
//  RMTestRender.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMRender.h"


@class RMVertexAttribute;
@class RMProgram;

@interface RMTestRender : NSObject<RMRenderDelegate>
@property (nonnull, nonatomic, copy, readonly) NSArray<RMVertexAttribute*>* attributes;
@property (nonnull, nonatomic, readonly) RMProgram* program;

+ (nonnull Class)programClass;

- (nonnull instancetype)initWithVertexShader:(nonnull  NSString*)vs fragmentShader:(nonnull NSString*)fs attributes:(nonnull NSArray<RMVertexAttribute*>*)attributes NS_DESIGNATED_INITIALIZER;

@end
