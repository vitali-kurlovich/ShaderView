//
//  UIColor+RMUtils.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/2/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RMUtils)

+ (UIColor*)colorWithColor:(UIColor*)color alpha:(CGFloat)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hex;
+ (UIColor *) colorWithHexString:(NSString *)hex withAlpha:(CGFloat)alpha;

@end
