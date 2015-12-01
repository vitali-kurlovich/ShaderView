//
//  RMSourceCodeTheme.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RMSourceCodeTheme : NSObject
- (nullable NSArray<NSString*>*)allKeywordTypes;

- (void)registerAttributesForType:(nonnull NSString*)type attr:(nonnull NSDictionary<NSString*, NSObject*>*)attr;
- ( nullable NSDictionary<NSString*, NSObject*>*)attributesKeywordType:(nonnull NSString*)type;

@end
