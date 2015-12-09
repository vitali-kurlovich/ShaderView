//
//  RMSceneObject.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/23/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RMCommon.h"



@class RMTransform, RMRender;

@interface RMSceneObject : NSObject

@property (nonnull, nonatomic, readonly) RMTransform* transform;
@property (nullable, nonatomic, readonly) RMRender* render;

@property (nullable, nonatomic) RMSceneObject* parent;
@property (nonnull, nonatomic,readonly) NSArray<RMSceneObject*>* child;



- (void)update:(rmtime)deltaTime;

- (void)start;

@end
