//
//  TextEditorViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "TextEditorViewController.h"

#import "RMSourceCodeTextView.h"

@interface TextEditorViewController () <UITextViewDelegate, NSTextStorageDelegate>
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
