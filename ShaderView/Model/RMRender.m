//
//  RMRender.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMRender.h"


@interface RMRender ()
{
    struct {
        unsigned int delegatePreRender:1;
        unsigned int delegatePostRender:1;
    } _renderFlags;
}

@end

@implementation RMRender


- (void)setDelegate:(id<RMRenderDelegate>)delegate
{
    if (_delegate != delegate)
    {
        _delegate = delegate;
        
        _renderFlags.delegatePreRender = [delegate respondsToSelector:@selector(preRender:duration:)];
        _renderFlags.delegatePostRender= [delegate respondsToSelector:@selector(postRender:duration:)];
    }
}

- (void)configureViewportWithX:(float)x y:(float)y width:(float)width height:(float)height
{
    
}

- (void)prepareRenderBuffersWithWidth:(float)width height:(float)height
{
    
}

- (void)preRender:(rmtime)deltaTime
{
    if (_renderFlags.delegatePreRender)
    {
        [self.delegate preRender:self duration:deltaTime];
    }
}

- (void)postRender:(rmtime)deltaTime
{
    if (_renderFlags.delegatePostRender)
    {
        [self.delegate postRender:self duration:deltaTime];
    }
}

- (void)render:(rmtime)deltaTime
{

}
@end
