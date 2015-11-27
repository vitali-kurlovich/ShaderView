//
//  RMShaderView.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

#import "RMRender.h"


@protocol RMRenderViewDelegate;
@interface RMRenderView : UIView

@property (nullable, nonatomic, weak) id<RMRenderViewDelegate> delegate;

- (void)preRender:(rmtime)deltaTime;
- (void)postRender:(rmtime)deltaTime;

- (void)render:(rmtime)deltaTime;
@end



@protocol RMRenderViewDelegate <NSObject>
@optional
- (void)renderView:(nullable RMRenderView*)render  preRenderWithDuration:(rmtime)deltaTime;
- (void)renderView:(nullable RMRenderView*)render  postRenderWithDuration:(rmtime)deltaTime;

- (void)renderView:(nullable RMRenderView*)render  renderWithDuration:(rmtime)deltaTime;

@end