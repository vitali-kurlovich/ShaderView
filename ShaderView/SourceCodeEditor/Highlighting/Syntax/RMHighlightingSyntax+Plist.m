//
//  RMSourceCodeSyntax+Plist.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/2/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMHighlightingSyntax.h"

static NSString* const kSourceCodeSyntaxPlistType = @"syntax";

static NSString* const kSourceCodeSyntaxPlistKeyKeyword  = @"keyword";
static NSString* const kSourceCodeSyntaxPlistKeySet = @"set";
static NSString* const kSourceCodeSyntaxPlistKeyRegExp = @"regexp";

@implementation RMHighlightingSyntax (Plist)

+ (nullable instancetype)syntaxNamed:(nonnull NSString*)name
{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:kSourceCodeSyntaxPlistType];
    
    if (path.length < 1)
    {
        return nil;
    }
    
    NSArray* arr = [NSArray arrayWithContentsOfFile:path];
    
    if (arr == nil)
    {
        return nil;
    }
    
    RMHighlightingSyntax* syntax = [[RMHighlightingSyntax alloc] init];
    
    for (NSDictionary* item in arr)
    {
        NSString* keyword = item[kSourceCodeSyntaxPlistKeyKeyword];
        
        if (!keyword)
        {
            continue;
        }
        
        NSArray* setitems = item[kSourceCodeSyntaxPlistKeySet];
        if (setitems)
        {
            if (setitems.count > 0) {
                
                NSSet* set = [NSSet setWithArray:setitems];
                
                RMSourceCodeSyntaxItem* syntaxItem = [[RMSourceCodeSyntaxItem alloc] initWithKeywordType:keyword set:set];
                
                [syntax registerSyntaxItem:syntaxItem];
                continue;
            }
        }
        
        
        NSString* regExp = item[kSourceCodeSyntaxPlistKeyRegExp];
        
        if (regExp.length > 0)
        {
            NSError  *error  = NULL;
            NSRegularExpression *regex = [NSRegularExpression
                                          regularExpressionWithPattern:regExp
                                          options:0
                                          error:&error];
            
            if (regex && error == nil) {
                RMSourceCodeSyntaxItem* syntaxItem = [[RMSourceCodeSyntaxItem alloc] initWithKeywordType:keyword regexp:regex];
                
                [syntax registerSyntaxItem:syntaxItem];
                continue;
            }
        }
    }
    
    return syntax;
}

@end
