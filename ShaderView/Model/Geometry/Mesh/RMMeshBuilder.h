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
@class RMTriangle3D, RMQuad3D;

@interface RMMeshBuilder : NSObject
- (nonnull RMMesh*)build;
- (void)reset;
- (void)appendTriangle:(nonnull RMTriangle3D*)triangle;
- (void)appendQuad:(nonnull RMQuad3D*)quad;
@end