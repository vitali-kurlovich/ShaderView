//
//  RDKeyboardObserver.h
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RDKeyboardObserverDelegate;

@interface RDKeyboardObserver : NSObject
@property (nonatomic, weak) id<RDKeyboardObserverDelegate> delegate;
@end

@interface  RDKeyboard : NSObject
@property (nonatomic, readonly) CGRect beginFrame;
@property (nonatomic, readonly) CGRect endFrame;

@property (nonatomic, readonly) UIViewAnimationCurve animationCurve;
@property (nonatomic, readonly) NSTimeInterval animationDuration;

@end


@protocol RDKeyboardObserverDelegate <NSObject>
@optional
- (void)keyboardObserver:(RDKeyboardObserver*)observer keyboardWillShow:(RDKeyboard*)keyboard;
- (void)keyboardObserver:(RDKeyboardObserver*)observer keyboardDidShow:(RDKeyboard*)keyboard;
- (void)keyboardObserver:(RDKeyboardObserver*)observer keyboardWillHide:(RDKeyboard*)keyboard;
- (void)keyboardObserver:(RDKeyboardObserver*)observer keyboardDidHide:(RDKeyboard*)keyboard;
@end