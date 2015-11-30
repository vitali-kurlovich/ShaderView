//
//  RMButon.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/27/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

IB_DESIGNABLE

@interface RMButton : UIControl

@property (nonatomic) IBInspectable BOOL vibrancy;

- (void)setBlurEffect:(nullable UIBlurEffect *)effect forState:(UIControlState)state;


- (void)setTitle:(nullable NSString *)title forState:(UIControlState)state;                     // default is nil. title is assumed to be single line
- (void)setTitleColor:(nullable UIColor *)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR; // default if nil. use opaque white
- (void)setTitleShadowColor:(nullable UIColor *)color forState:(UIControlState)state UI_APPEARANCE_SELECTOR; // default is nil. use 50% black
- (void)setImage:(nullable UIImage *)image forState:(UIControlState)state;                      // default is nil. should be same size if different for different states
- (void)setBackgroundImage:(nullable UIImage *)image forState:(UIControlState)state UI_APPEARANCE_SELECTOR; // default is nil
- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state;



- (CGRect)backgroundRectForBounds:(CGRect)bounds;
- (CGRect)contentRectForBounds:(CGRect)bounds;
- (CGRect)titleRectForContentRect:(CGRect)contentRect;
- (CGRect)imageRectForContentRect:(CGRect)contentRect;

@end
