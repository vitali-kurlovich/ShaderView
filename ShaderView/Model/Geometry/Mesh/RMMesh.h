//
//  RMMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "RMDrawable.h"

@class RMVBOObject;
@class RMProgram;

@interface RMMesh : NSObject <RMDrawable>
@property (nullable, nonatomic, readonly) RMVBOObject* vbo;
@property (nullable, nonatomic) RMProgram* program;

+ (nonnull instancetype)mesh;
+ (nonnull instancetype)meshWithVBO:(nullable RMVBOObject*)vbo program:(nullable RMProgram*)program;
+ (nonnull instancetype)meshWithVBO:(nullable RMVBOObject*)vbo;

- (nonnull instancetype)initWithVBO:(nullable RMVBOObject*)vbo program:(nullable RMProgram*)program;
- (nonnull instancetype)initWithVBO:(nullable RMVBOObject*)vbo;

@end


