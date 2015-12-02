//
//  RMSourceCodeThemeProcessor.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMSourceCodeTheme;
@class RMSourceCodeSyntax;

@interface RMSourceCodeThemeProcessor : NSObject

@property (nullable, nonatomic, copy) RMSourceCodeTheme* theme;
@property (nullable, nonatomic, copy) RMSourceCodeSyntax* syntax;


- (void)processAttributesForText:(nullable NSString*)text
                     searchRange:(NSRange)searchRange
                      usingBlock:(void (^ __nullable)(NSRange attrRange, NSDictionary<NSString*, NSObject*> * __nullable attr))block;

@end
