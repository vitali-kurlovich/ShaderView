//
//  RMSourceCodeThemeProcessor.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMHighlightingProcessor.h"

#import "RMHighlightingTheme.h"
#import "RMHighlightingSyntax.h"


@interface RMHighlightingProcessor ()
@property (nonatomic, readonly) NSArray<RMSourceCodeSyntaxItem*>* setItems;
@end


@implementation RMHighlightingProcessor

@synthesize setItems = _setItems;

- ( NSArray<RMSourceCodeSyntaxItem*>*)setItems
{
    if (_setItems == nil)
    {
        NSArray<NSString*>* types = [self.theme allKeywordTypes];
        NSMutableArray<RMSourceCodeSyntaxItem*>* array = [NSMutableArray arrayWithCapacity:types.count];
        
        for (NSString* key in types) {
            RMSourceCodeSyntaxItem* item = [self.syntax itemForSyntaxKeyword:key];
            
            if (item && item.type == RMSourceCodeSyntaxItemTypeSet)
            {
                [array addObject:item];
            }
        }
        
        _setItems = [array copy];
    }
    
    return _setItems;
}


- (void)setTheme:(RMHighlightingTheme *)theme
{
    if (_theme != theme)
    {
        _theme = [theme copy];
        _setItems = nil;
    }
}

- (void)setSyntax:(RMHighlightingSyntax *)syntax
{
    if (_syntax != syntax)
    {
        _syntax = [syntax copy];
        _setItems = nil;
    }
}


- (void)processAttributesForText:(NSString*)text searchRange:(NSRange)searchRange usingBlock:(void (^)(NSRange attrRange, NSDictionary<NSString*, NSObject*>* attr))block
{
    if (block == nil) return;
    
    NSArray* setItems = self.setItems;
    RMHighlightingTheme* theme = self.theme;
    
    [text enumerateSubstringsInRange:searchRange options:NSStringEnumerationByWords usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        for (RMSourceCodeSyntaxItem* item in setItems) {
            if ([item.set containsObject:substring])
            {
                NSDictionary<NSString*, NSObject*>* attributs = [theme attributesKeywordType:item.keywordType];
                
                block(substringRange, attributs);
                
                return ;
            }
        }
        
        block(substringRange, nil);
    }];
}

@end
