//
//  TextEditorViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSourceCodeViewController.h"

#import "RMSourceCodeTextView.h"

@interface RMSourceCodeViewController () <UITextViewDelegate, NSTextStorageDelegate>
@property (nonatomic) IBOutlet RMSourceCodeTextView* textView;
@end

@implementation TextEditorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    

}



@end
