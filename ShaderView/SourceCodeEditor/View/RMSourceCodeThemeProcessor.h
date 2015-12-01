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
@property (nonatomic) RMSourceCodeTheme* theme;
@property (nonatomic) RMSourceCodeSyntax* syntax;


- (void)processAttributesForText:(NSString*)text searchRange:(NSRange)searchRange usingBlock:(void (^)(NSRange attrRange, NSDictionary<NSString*, NSObject*>* attr))block;

@end
