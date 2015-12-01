//
//  RMMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMMath.h"
#import "RMDrawable.h"

@class RMVBOObject;

@interface RMMesh : NSObject <RMDrawable>
@property (nonnull, nonatomic, readonly) RMVBOObject* vbo;

@end


@interface RMMeshBuilder : NSObject
- (nonnull RMMesh*)build;


- (void)appendVertex3d:(_RMVector3)vec;

- (void)appendVertex3d:(_RMVector3)vec normal:(_RMVector3)normal uv0:(_RMVector2)uv0;

@end