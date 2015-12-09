//
//  RMMeshRender.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMRender.h"

@class RMVBORender;
@class RMMesh;

typedef NS_ENUM(NSInteger, RMMeshRenderMode) {
    RMMeshRenderSolid,
    RMMeshRenderWireframe
};

@interface RMMeshRender : RMRender
@property (nullable, nonatomic) RMMesh* mesh;
@property (nonatomic) RMMeshRenderMode mode;

@property (nonnull, nonatomic, readonly) RMVBORender* solidRender;
@property (nonnull, nonatomic, readonly) RMVBORender* wireframeRender;

@end
