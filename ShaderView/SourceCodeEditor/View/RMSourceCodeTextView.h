//
//  RMTextView.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

@class RMSourceCodeTheme;
@class RMSourceCodeSyntax;

IB_DESIGNABLE

@interface RMSourceCodeTextView : UITextView

@property (nullable, nonatomic, copy) RMSourceCodeTheme* theme;
@property (nullable, nonatomic, copy) RMSourceCodeSyntax* syntax;

@property (nonatomic) IBInspectable CGFloat lineNumberWidth;
@property (nullable, nonatomic) IBInspectable UIFont* lineNumberFont;
@property (nullable, nonatomic) IBInspectable UIColor* lineNumberBackgroundColor;
@property (nullable, nonatomic) IBInspectable UIColor* lineNumberTextColor;


@end
