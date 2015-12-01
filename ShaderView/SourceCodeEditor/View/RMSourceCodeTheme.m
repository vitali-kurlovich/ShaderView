//
//  RMSourceCodeTheme.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSourceCodeTheme.h"

#import "RMSourceCodeSyntax.h"
@import UIKit;

@interface RMSourceCodeTheme ()
@property (nonatomic, readonly) NSMutableDictionary<NSString*, NSDictionary<NSString*, NSObject*>*>* attrs;
@end


@implementation RMSourceCodeTheme

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _attrs = [
                  @{
                    kSyntaxKeywordType : @{ NSForegroundColorAttributeName : [UIColor redColor] },
                    kSyntaxKeywordStatement : @{ NSForegroundColorAttributeName : [UIColor blueColor] },
                    kSyntaxKeywordModifier : @{ NSForegroundColorAttributeName : [UIColor magentaColor] },
                    
                    kSyntaxKeywordGlobalFunc : @{ NSForegroundColorAttributeName : [UIColor orangeColor] },
                    } mutableCopy];
    }
    return self;
}

- (NSArray<NSString*>*)allKeywordTypes
{
    return [self.attrs allKeys];
}


- (void)registerAttributesForType:(nonnull NSString*)type attr:(NSDictionary<NSString*, NSObject*>*)attr
{
    self.attrs[type] = attr;
}

- (nullable NSDictionary<NSString*, NSObject*>*)attributesKeywordType:(nonnull NSString*)type;
{
    return self.attrs[type];
}
@end
