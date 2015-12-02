//
//  RMSourceCodeSyntax.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSourceCodeSyntax.h"

NSString* const kSyntaxKeywordStatement = @"keyword.statement";
NSString* const kSyntaxKeywordType = @"keyword.type";
NSString* const kSyntaxKeywordModifier = @"keyword.modifier";

NSString* const kSyntaxKeywordGlobalVars = @"keyword.global.vars";
NSString* const kSyntaxKeywordGlobalConst = @"keyword.global.const";
NSString* const kSyntaxKeywordGlobalFunc = @"keyword.global.func";


@interface RMSourceCodeSyntax ()
@property (nonatomic, readonly) NSMutableDictionary<NSString*, RMSourceCodeSyntaxItem*>* items;
@end

@implementation RMSourceCodeSyntax

- (instancetype)init
{
    return [self initWithItems:nil];
}

- (nonnull instancetype)initWithItems:(nullable NSDictionary<NSString*, RMSourceCodeSyntaxItem*>*)items
{
    self = [super init];
    if (self)
    {
        if (items)
        {
            _items = [items mutableCopy];
        } else {
            _items = [NSMutableDictionary dictionary];
        }
    }
    return self;
}


- (void)registerSyntaxItem:(RMSourceCodeSyntaxItem*)item
{
    self.items[item.keywordType] = item;
}

- (RMSourceCodeSyntaxItem*)itemForSyntaxKeyword:(NSString*)keyword
{
    return self.items[keyword];
}


#pragma mark - NSCopying

- (id)copyWithZone:(nullable NSZone *)zone
{
   return [[RMSourceCodeSyntax alloc] initWithItems:self.items];
}

@end



@implementation RMSourceCodeSyntaxItem

- (instancetype)init
{
    NSString* keyword = nil;
    return [self initWithKeywordType:keyword type:RMSourceCodeSyntaxItemTypeRegExp];
}

- (nonnull instancetype)initWithKeywordType:(nonnull NSString*)keywordType type:(RMSourceCodeSyntaxItemType)type
{
    self = [super init];
    if (self)
    {
        _keywordType = [keywordType copy];
        _type = type;
    }
    return self;
}


- (nonnull instancetype)initWithKeywordType:(nonnull NSString*)keywordType regexp:(nonnull NSRegularExpression*)regexp
{
    self = [self initWithKeywordType:keywordType type:RMSourceCodeSyntaxItemTypeRegExp];
    if (self)
    {
        _regExp = [regexp copy];
    }
    
    return self;
}

- (nonnull instancetype)initWithKeywordType:(nonnull NSString*)keywordType set:(nonnull  NSSet<NSString*>*)set
{
    self = [self initWithKeywordType:keywordType type:RMSourceCodeSyntaxItemTypeSet];
    if (self)
    {
        _set = [set copy];
    }
    return self;
}

@end
