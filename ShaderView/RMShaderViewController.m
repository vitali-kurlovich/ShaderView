//
//  RMShaderViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMShaderViewController.h"


@interface RMShaderViewController ()
@property (nonatomic) IBOutlet RMRenderView* shaderView;
@end

@implementation RMShaderViewController

- (instancetype)init
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RMShaderViewController"];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.shaderView.render.delegate = self.renderDelegate;
}

@end
