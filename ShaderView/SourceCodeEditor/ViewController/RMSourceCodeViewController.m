//
//  TextEditorViewController.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSourceCodeViewController.h"

#import "RMSourceCodeTextView.h"
#import "RDKeyboardObserver.h"


@interface RMSourceCodeViewController () <UITextViewDelegate, NSTextStorageDelegate, RDKeyboardObserverDelegate>

@property (nonatomic) RDKeyboardObserver* keyboardObserver;
@end

@implementation RMSourceCodeViewController
@synthesize sorceCode = _sorceCode;
@synthesize textView = _textView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.keyboardObserver = [[RDKeyboardObserver alloc] init];
    self.keyboardObserver.delegate = self;
    
    self.textView.text = _sorceCode;
    
    self.textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    _sorceCode = nil;
}

- (void)loadView
{
    _textView = [[RMSourceCodeTextView alloc] init];
    self.view = _textView;
}

- (void)setSorceCode:(NSString *)sorceCode
{
    if ([self isViewLoaded])
    {
        self.textView.text = sorceCode;
        _sorceCode = nil;
    } else {
        _sorceCode = [sorceCode copy];
    }
}

- (NSString*)sorceCode
{
    if ([self isViewLoaded])
    {
        return [self.textView.text copy];
    }
    return _sorceCode;
}

- (void)loadTextFileWithName:(NSString*)name ofType:(NSString*)type
{
    NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if (path.length < 1)
    {
        return;
    }
    
    NSError* error;
    NSString* textString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    self.sorceCode = textString;
    
    if (!textString)
    {
        NSLog(@"Error loading file: %@", error.localizedDescription);
    }
}


#pragma mark - RDKeyboardObserverDelegate <NSObject>

- (void)keyboardObserver:(RDKeyboardObserver*)observer keyboardDidShow:(RDKeyboard*)keyboard
{
    CGRect keyRect =  [self.textView convertRect:keyboard.endFrame fromView:nil];
    
    UIEdgeInsets contentInsets =  self.textView.contentInset;
    contentInsets.bottom = CGRectGetHeight(keyRect);
    self.textView.contentInset = contentInsets;
    
    UIEdgeInsets scrollInsets = self.textView.scrollIndicatorInsets;
    scrollInsets.bottom = CGRectGetHeight(keyRect);
    self.textView.scrollIndicatorInsets = scrollInsets;
}

- (void)keyboardObserver:(RDKeyboardObserver*)observer keyboardWillHide:(RDKeyboard*)keyboard
{
    UIEdgeInsets contentInsets =  self.textView.contentInset;
    
    contentInsets.bottom = 0;
    
    self.textView.contentInset = contentInsets;
    
    UIEdgeInsets scrollInsets = self.textView.scrollIndicatorInsets;
    scrollInsets.bottom = 0;
    self.textView.scrollIndicatorInsets = scrollInsets;
}

@end
