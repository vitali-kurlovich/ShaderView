//
//  RMSourceCodeTheme+Plist.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/2/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSourceCodeTheme.h"

#import "UIColor+RMUtils.h"


static NSString* const kSourceCodeThemePlistType = @"theme";

static NSString* const kSourceCodeThemePlistHighlighting = @"highlighting";
static NSString* const kSourceCodeThemeFontColorKey = @"fontcolor";

static NSDictionary* _themeItemToAttr( NSDictionary<NSString*, id>* item);

@implementation RMSourceCodeTheme (Plist)

+ (nullable instancetype)themeNamed:(nonnull NSString*)name
{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:kSourceCodeThemePlistType];
    
    if (path.length < 1)
    {
        return nil;
    }
    
    NSDictionary<NSString*, NSDictionary<NSString*, NSDictionary*>*>* dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSDictionary<NSString*, NSDictionary<NSString*, id>*>* highlighting = dict[kSourceCodeThemePlistHighlighting];
    
    if (highlighting == nil)
    {
        return nil;
    }
    
    RMSourceCodeTheme* theme = [[RMSourceCodeTheme alloc] init];
    
    [highlighting enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSDictionary<NSString *,id> * _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSDictionary* attr = _themeItemToAttr(obj);
        if (attr.count > 0) {
            [theme registerAttributesForType:key attr:attr];
        }
    }];
    
    
    return theme;
}

inline NSDictionary* _themeItemToAttr( NSDictionary<NSString*, id>* item)
{
    NSMutableDictionary* attr = [NSMutableDictionary dictionaryWithCapacity:item.count];
    
    NSString* fontColor = item[kSourceCodeThemeFontColorKey];
    
    if (fontColor.length > 0)
    {
        attr[NSForegroundColorAttributeName] = [UIColor colorWithHexString:fontColor];
       
    }
    
    return [attr copy];
}

@end
