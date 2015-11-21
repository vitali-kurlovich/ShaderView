//
//  RMTextView.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface RMSourceCodeTextView : UITextView

@property (nonatomic) IBInspectable CGFloat lineNumberWidth;
@property (nullable, nonatomic) IBInspectable UIFont* lineNumberFont;
@property (nullable, nonatomic) IBInspectable UIColor* lineNumberBackgroundColor;
@property (nullable, nonatomic) IBInspectable UIColor* lineNumberTextColor;

- (NSUInteger)numberOfLines;
- (CGRect)rectForLineAtIndex:(NSInteger)index;
@end
