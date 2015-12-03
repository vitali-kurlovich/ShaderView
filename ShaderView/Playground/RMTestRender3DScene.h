//
//  RMTestRender3DScene.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTestRender.h"

@interface RMTestRender3DScene : RMTestRender
- (nonnull instancetype)initWithVertexShader:(nonnull NSString*)vs fragmentShader:(nonnull NSString*)fs;
@end
