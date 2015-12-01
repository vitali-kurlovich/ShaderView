//
//  RMSourceCodeSyntax.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import Foundation;


typedef NS_ENUM(NSInteger, RMSourceCodeSyntaxItemType) {
    RMSourceCodeSyntaxItemTypeRegExp,
    RMSourceCodeSyntaxItemTypeSet
};

NS_ASSUME_NONNULL_BEGIN

extern NSString* const kSyntaxKeywordType;
extern NSString* const kSyntaxKeywordModifier;
extern NSString* const kSyntaxKeywordStatement;

extern NSString* const kSyntaxKeywordGlobalVars;
extern NSString* const kSyntaxKeywordGlobalConst;
extern NSString* const kSyntaxKeywordGlobalFunc;

NS_ASSUME_NONNULL_END

@class RMSourceCodeSyntaxItem;

@interface RMSourceCodeSyntax : NSObject

- (void)registerSyntaxItem:(nonnull RMSourceCodeSyntaxItem*)item;
- ( nonnull RMSourceCodeSyntaxItem*)itemForSyntaxKeyword:(nonnull NSString*)keyword;

@end


@interface RMSourceCodeSyntax (Plist)

+ (nullable instancetype)syntaxNamed:(nonnull NSString*)name;

@end


@interface RMSourceCodeSyntaxItem : NSObject
@property (nonatomic, readonly) NSInteger priority;
@property (nonatomic, readonly) RMSourceCodeSyntaxItemType type;
@property (nonnull, nonatomic, copy, readonly) NSString* keywordType;
@property (nullable, nonatomic, copy, readonly) NSRegularExpression* regExp;
@property (nullable, nonatomic, copy, readonly) NSSet<NSString*>* set;

- (nonnull instancetype)initWithKeywordType:(nonnull NSString*)keywordType type:(RMSourceCodeSyntaxItemType)type NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithKeywordType:(nonnull NSString*)keywordType regexp:(nonnull NSRegularExpression*)regexp;
- (nonnull instancetype)initWithKeywordType:(nonnull NSString*)keywordType set:(nonnull  NSSet<NSString*>*)set;
@end
