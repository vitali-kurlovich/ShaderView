//
//  RMShaderViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMShaderEditorTabViewController.h"

#import "RMSourceCodeViewController.h"

@interface RMShaderEditorTabViewController ()
@property (nonatomic, readonly)  RMSourceCodeViewController* vertexShaderEditor;
@property (nonatomic, readonly)  RMSourceCodeViewController* fragmentShaderEditor;
@end


@implementation RMShaderEditorTabViewController

- (RMSourceCodeViewController*)vertexShaderEditor
{
    return self.viewControllers[0];
}

- (RMShaderEditorTabViewController*)fragmentShaderEditor
{
    return self.viewControllers[1];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(play:)];
}

- (IBAction)play:(id)sender
{
    NSString* vs = [self.vertexShaderEditor sorceCode];
    NSString* fs = [self.fragmentShaderEditor sorceCode];
    
    
    
}

@end
