//
//  RMMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMVBOObject;

@interface RMMesh : NSObject
@property (nullable, nonatomic, readonly) RMVBOObject* vbo;

+ (nonnull instancetype)mesh;
+ (nonnull instancetype)meshWithVBO:(nullable RMVBOObject*)vbo;

- (nonnull instancetype)initWithVBO:(nullable RMVBOObject*)vbo;

@end


