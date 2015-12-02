//
//  RMSourceCodeThemeProcessor.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMHighlightingTheme;
@class RMHighlightingSyntax;

@interface RMHighlightingProcessor : NSObject

@property (nullable, nonatomic, copy) RMHighlightingTheme* theme;
@property (nullable, nonatomic, copy) RMHighlightingSyntax* syntax;


- (void)processAttributesForText:(nullable NSString*)text
                     searchRange:(NSRange)searchRange
                      usingBlock:(void (^ __nullable)(NSRange attrRange, NSDictionary<NSString*, NSObject*> * __nullable attr))block;

@end
