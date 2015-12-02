//
//  RMMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "RMDrawable.h"

@class RMVBOObject;
@class RMProgram;

@interface RMMesh : NSObject <RMDrawable>
@property (nonnull, nonatomic, readonly) RMVBOObject* vbo;
@property (nonnull, nonatomic) RMProgram* program;

@end


