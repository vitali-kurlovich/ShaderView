//
//  RMShaderView.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

@class RMGLSLProgram;

@interface RMShaderView : UIView
@property (nullable, readonly) RMGLSLProgram* program;

- (void)render;

@end
