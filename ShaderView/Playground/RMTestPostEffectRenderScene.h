//
//  RMTestRenderScene.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//


#import "RMTestRender.h"


@interface RMTestPostEffectRenderScene : RMTestRender

- (nonnull instancetype)initWithVertexShader:(nonnull NSString*)vs fragmentShader:(nonnull NSString*)fs;


@end
