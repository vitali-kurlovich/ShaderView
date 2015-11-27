//
//  RDKeyboardObserver.m
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

#import "RDKeyboardObserver.h"

@interface  RDKeyboard (MMNotification)
- (instancetype)initWithNotification:(NSNotification*)notification;
@end



@interface RDKeyboardObserver()
{
    struct {
    unsigned int keyboardWillShow:1;
    unsigned int keyboardDidShow:1;
    unsigned int keyboardWillHide:1;
    unsigned int keyboardDidHide:1;
    } _delegateFlags;
}

@end

@implementation RDKeyboardObserver

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setDelegate:(id<RDKeyboardObserverDelegate>)delegate
{
    if (_delegate != delegate)
    {
        _delegate = delegate;
        
        _delegateFlags.keyboardDidHide = [delegate respondsToSelector:@selector(keyboardObserver:keyboardDidHide:)];
        _delegateFlags.keyboardDidShow = [delegate respondsToSelector:@selector(keyboardObserver:keyboardDidShow:)];
        
        _delegateFlags.keyboardWillHide = [delegate respondsToSelector:@selector(keyboardObserver:keyboardWillHide:)];
        _delegateFlags.keyboardWillShow = [delegate respondsToSelector:@selector(keyboardObserver:keyboardWillShow:)];
        
        [self _setupKeyboardNotification];
    }
}

- (void)_setupKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if (_delegateFlags.keyboardWillShow)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    }
    
    if (_delegateFlags.keyboardWillHide)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    if (_delegateFlags.keyboardDidShow)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
    }
    
    if (_delegateFlags.keyboardDidHide)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:nil];
    }
}

- (void)keyboardDidHideNotification:(NSNotification*)notification
{
    [self.delegate keyboardObserver:self keyboardDidHide:[[RDKeyboard alloc] initWithNotification:notification]];
}

- (void)keyboardDidShowNotification:(NSNotification*)notification
{
    [self.delegate keyboardObserver:self keyboardDidShow:[[RDKeyboard alloc] initWithNotification:notification]];
    
}

- (void)keyboardWillShowNotification:(NSNotification*)notification
{
     [self.delegate keyboardObserver:self keyboardWillShow:[[RDKeyboard alloc] initWithNotification:notification]];
}

- (void)keyboardWillHideNotification:(NSNotification*)notification
{
    [self.delegate keyboardObserver:self keyboardWillHide:[[RDKeyboard alloc] initWithNotification:notification]];
}



@end

@implementation RDKeyboard

- (instancetype)initWithNotification:(NSNotification*)notification
{
    self = [super init];
    if (self)
    {
        NSDictionary* info = notification.userInfo;
        NSValue* value = info[UIKeyboardFrameBeginUserInfoKey];
        _beginFrame = [value CGRectValue];
        
        value = info[UIKeyboardFrameEndUserInfoKey];
        _endFrame = [value CGRectValue];
        
        NSNumber* anim = info[UIKeyboardAnimationCurveUserInfoKey];
        
        _animationCurve = [anim integerValue];
        
         NSNumber* duration = info[UIKeyboardAnimationDurationUserInfoKey];
        _animationDuration = [duration doubleValue];
        
    }
    return self;
}

- (NSString*)description
{
    return [@{@"beginFrame":[NSValue valueWithCGRect:self.beginFrame],
              @"endFrame":[NSValue valueWithCGRect:self.endFrame],
              @"animationDuration":@(self.animationDuration),
              @"animationCurve":@(self.animationCurve),
              } description];
}
@end
