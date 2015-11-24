//
//  RMVertexShaderCodeViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/24/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVertexShaderCodeViewController.h"

@implementation RMVertexShaderCodeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self loadTextFileWithName:@"Julia" ofType:@"vert"];
}
@end
