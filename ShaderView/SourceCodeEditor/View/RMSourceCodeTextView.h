//
//  RMTextView.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

@class RMHighlightingTheme;
@class RMHighlightingSyntax;

IB_DESIGNABLE

@interface RMSourceCodeTextView : UITextView

@property (nullable, nonatomic, copy) RMHighlightingTheme* theme;
@property (nullable, nonatomic, copy) RMHighlightingSyntax* syntax;

@property (nonatomic) IBInspectable CGFloat lineNumberWidth;
@property (nullable, nonatomic) IBInspectable UIFont* lineNumberFont;
@property (nullable, nonatomic) IBInspectable UIColor* lineNumberBackgroundColor;
@property (nullable, nonatomic) IBInspectable UIColor* lineNumberTextColor;


@end
