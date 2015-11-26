//
//  RMShaderView.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

#import "RMRender.h"

@class RMGLSLProgram;

@class RMRender;


@interface RMShaderView : UIView

@property (nullable, nonatomic, readonly) RMRender* render;


- (void)preRender:(rmtime)deltaTime;
- (void)postRender:(rmtime)deltaTime;

- (void)render:(rmtime)deltaTime;


@end
