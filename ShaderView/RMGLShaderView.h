//
//  RMGLShaderView.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMShaderView.h"


@class RMGLRender;

@interface RMGLShaderView : RMShaderView
@property (nonatomic, readonly) RMGLRender* glRender;

@end
