//
//  RMTestRenderScene.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//


#import "RMTestRender.h"


@interface RMTestPostEffectRenderScene : RMTestRender

- (instancetype)initWithVertexShader:(NSString*)vs fragmentShader:(NSString*)fs;


@end
