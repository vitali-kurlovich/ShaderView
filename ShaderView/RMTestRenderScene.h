//
//  RMTestRenderScene.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMRender.h"



@interface RMTestRenderScene : NSObject<RMRenderDelegate>

- (instancetype)initWithVertexShader:(NSString*)vs fragmentShader:(NSString*)fs;


@end
