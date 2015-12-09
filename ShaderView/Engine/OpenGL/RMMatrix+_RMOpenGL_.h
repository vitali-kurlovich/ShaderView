//
//  RMMatrix+_RMOpenGL_.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMatrix.h"

@import OpenGLES;

@interface RMMatrix (_RMOpenGL_)
- (const GLfloat*)glMatrix;
@end
