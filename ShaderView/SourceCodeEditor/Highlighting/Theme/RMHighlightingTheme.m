//
//  RMSourceCodeTheme.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMHighlightingTheme.h"

#import "RMHighlightingSyntax.h"
@import UIKit;

@interface RMHighlightingTheme ()
@property (nonatomic, readonly) NSMutableDictionary<NSString*, NSDictionary<NSString*, NSObject*>*>* attrs;
@end


@implementation RMHighlightingTheme

- (instancetype)init
{
    return [self initWithAttributess:nil];
}


- (instancetype)initWithAttributess:( NSDictionary<NSString*, NSDictionary<NSString*, NSObject*>*>*)attrs
{
    self = [super init];
    if (self)
    {
        if (attrs)
        {
            _attrs = [attrs mutableCopy];
        } else {
            _attrs = [NSMutableDictionary dictionary];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredContentSizeChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)preferredContentSizeChanged:(NSNotification *)aNotification
{
    
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


#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone;
{
    return [[RMHighlightingTheme alloc] initWithAttributess:self.attrs];
}

@end








