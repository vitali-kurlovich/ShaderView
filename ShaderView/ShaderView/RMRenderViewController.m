//
//  RMRenderViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/27/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMRenderViewController.h"

#import "RMRenderView.h"

@interface RMRenderViewController ()
@property (nonatomic) CADisplayLink* displayLink;
@end


@implementation RMRenderViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self _render:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_render:)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.displayLink invalidate];
    self.displayLink = nil;
}


- (void)loadView
{
    RMRenderView* renderView = [[RMRenderView alloc] init];
    renderView.delegate = self;
    self.view = renderView;
}


- (RMRenderView*)renderView
{
    if ([self isViewLoaded])
    {
        return (RMRenderView*)self.view;
    }
    
    return nil;
}


- (void)_render:(CADisplayLink*)displayLink
{
    [self.renderView preRender:displayLink.duration];
    [self.renderView render:displayLink.duration];
    [self.renderView postRender:displayLink.duration];
}

@end
