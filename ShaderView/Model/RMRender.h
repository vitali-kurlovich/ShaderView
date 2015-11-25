//
//  RMRender.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMCommon.h"

@protocol RMRenderDelegate;

@interface RMRender : NSObject

@property (nullable, nonatomic, weak) id<RMRenderDelegate> delegate;

- (void)render:(rmtime)deltaTime;
- (void)preRender:(rmtime)deltaTime;
- (void)postRender:(rmtime)deltaTime;

- (void)configureViewportWithX:(float)x y:(float)y width:(float)width height:(float)height;

- (void)prepareRenderBuffersWithWidth:(float)width height:(float)height;

@end



@protocol RMRenderDelegate <NSObject>
@optional
- (void)preRender:(nullable RMRender*)render duration:(rmtime)deltaTime;
- (void)postRender:(nullable RMRender*)render duration:(rmtime)deltaTime;

- (void)render:(nullable RMRender*)render duration:(rmtime)deltaTime;

@end


@interface RMRenderConfig : NSObject

@end