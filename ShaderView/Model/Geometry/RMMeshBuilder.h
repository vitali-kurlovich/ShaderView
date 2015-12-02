//
//  RMMeshBuilder.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/2/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import Foundation;

#import "RMMath.h"

@class RMMesh;

@interface RMMeshBuilder : NSObject
- (nonnull RMMesh*)build;


- (void)appendVertex3d:(_RMVector3)vec;

- (void)appendVertex3d:(_RMVector3)vec normal:(_RMVector3)normal uv0:(_RMVector2)uv0;

@end