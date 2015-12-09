//
//  RMMatrix+_RMOpenGL_.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMatrix+_RMOpenGL_.h"

#import "RMMatrix2x2.h"
#import "RMMatrix3x3.h"
#import "RMMatrix4x4.h"



@implementation RMMatrix (_RMOpenGL_)
- (const GLfloat*)glMatrix
{
    return nil;
}
@end



@implementation RMMatrix4x4 (_RMOpenGL_)

- (const GLfloat*)glMatrix
{
    const GLfloat* r = (GLfloat*) &self->_matrix;
    return r;
}
@end
