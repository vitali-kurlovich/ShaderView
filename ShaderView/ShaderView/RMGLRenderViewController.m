//
//  RMGLRenderViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/27/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMGLRenderViewController.h"

#import "RMGLRenderView.h"

@implementation RMGLRenderViewController

- (void)loadView
{
    RMRenderView* renderView = [[RMGLRenderView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    renderView.delegate = self;
    self.view = renderView;
}

@end
