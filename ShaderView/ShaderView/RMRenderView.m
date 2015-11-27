//
//  RMShaderView.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMRenderView.h"


@interface RMRenderView ()
{
    struct {
        unsigned int delegatePreRender:1;
        unsigned int delegatePostRender:1;
        unsigned int delegateRender:1;
    } _viewFlags;
}
@end

@implementation RMRenderView

- (void)setDelegate:(id<RMRenderViewDelegate>)delegate
{
    if (_delegate != delegate)
    {
        _delegate = delegate;
        
        _viewFlags.delegatePostRender = [delegate respondsToSelector:@selector(renderView:postRenderWithDuration:)];
        _viewFlags.delegatePreRender = [delegate respondsToSelector:@selector(renderView:preRenderWithDuration:)];
        _viewFlags.delegateRender = [delegate respondsToSelector:@selector(renderView:renderWithDuration:)];
    }
}


- (void)preRender:(rmtime)deltaTime
{
    if (_viewFlags.delegatePreRender)
    {
        [self.delegate renderView:self preRenderWithDuration:deltaTime];
    }
}

- (void)postRender:(rmtime)deltaTime
{
    if (_viewFlags.delegatePostRender)
    {
        [self.delegate renderView:self postRenderWithDuration:deltaTime];
    }
}

- (void)render:(rmtime)deltaTime
{
    if (_viewFlags.delegateRender)
    {
        [self.delegate renderView:self renderWithDuration:deltaTime];
    }
}

@end
