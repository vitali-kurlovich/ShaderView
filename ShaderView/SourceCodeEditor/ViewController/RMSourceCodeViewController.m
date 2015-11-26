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

@implementation RMSourceCodeViewController

- (NSString*)sorceCode
{
    return [self.textView.text copy];
}

- (void)loadTextFileWithName:(NSString*)name ofType:(NSString*)type
{
    NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    
    if (path.length < 1)
    {
        return ;
    }
    
    NSError* error;
    NSString* textString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (textString)
    {
        self.textView.text = textString;
    } else {
        NSLog(@"Error loading file: %@", error.localizedDescription);
        return;
    }
}

@end
