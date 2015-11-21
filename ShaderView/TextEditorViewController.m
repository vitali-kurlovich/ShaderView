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
    
    self.textView.textStorage.delegate = self;
    
    NSInteger lines = [self.textView numberOfLines];
    
    NSLog(@"Line number is:%@", @(lines));
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
    CGRect rect = [self.textView rectForLineAtIndex:0];
    
    NSLog(@"Rect: %@", NSStringFromCGRect(rect));
    
}

#pragma mark - NSTextStorageDelegate

// Sent inside -processEditing right before fixing attributes.  Delegates can change the characters or attributes.
- (void)textStorage:(NSTextStorage *)textStorage willProcessEditing:(NSTextStorageEditActions)editedMask range:(NSRange)editedRange changeInLength:(NSInteger)delta{
 
    
    
}

// Sent inside -processEditing right before notifying layout managers.  Delegates can change the attributes.
- (void)textStorage:(NSTextStorage *)textStorage didProcessEditing:(NSTextStorageEditActions)editedMask range:(NSRange)editedRange changeInLength:(NSInteger)delta {
    
    
    self.textView.textStorage.delegate = self;
    

    
}

@end
