//
//  RMSourceCodeTextStorage.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMHighlightingTextStorage.h"

#import "RMHighlightingProcessor.h"


@interface RMHighlightingTextStorage ()
{
    NSMutableAttributedString *_backingStore;
    BOOL _dynamicTextNeedsUpdate;
}

@property (nonatomic, readonly) RMHighlightingProcessor* themeProcessor;

@end


@implementation RMHighlightingTextStorage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _backingStore = [[NSMutableAttributedString alloc] init];
        _themeProcessor = [[RMHighlightingProcessor alloc] init];
        
    }
    return self;
}

- (void)setSyntax:(RMHighlightingSyntax *)syntax
{
    self.themeProcessor.syntax = syntax;
}

- (RMHighlightingSyntax*)syntax
{
    return self.themeProcessor.syntax;
}

- (void)setTheme:(RMHighlightingTheme *)theme
{
    self.themeProcessor.theme = theme;
}

- (RMHighlightingTheme *)theme
{
    return self.themeProcessor.theme;
}


- (NSString *)string
{
    return [_backingStore string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [_backingStore attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    [self beginEditing];
    [_backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters|NSTextStorageEditedAttributes range:range changeInLength:str.length - range.length];
    _dynamicTextNeedsUpdate = YES;
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range
{
    [self beginEditing];
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

- (void)performReplacementsForCharacterChangeInRange:(NSRange)changedRange
{
    NSString* string = [_backingStore string];
    NSRange extendedRange = NSUnionRange(changedRange, [string lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [string lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    
    [self applyTokenAttributesToRange:extendedRange];
}

-(void)processEditing
{
    if(_dynamicTextNeedsUpdate)
    {
        _dynamicTextNeedsUpdate = NO;
        [self performReplacementsForCharacterChangeInRange:[self editedRange]];
    }
    [super processEditing];
}

- (void)applyTokenAttributesToRange:(NSRange)searchRange
{
    NSString* text = [_backingStore string];
    NSDictionary<NSString*, id>* defaultAttrs = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    
    [self.themeProcessor processAttributesForText:text searchRange:searchRange usingBlock:^(NSRange attrRange, NSDictionary<NSString *,NSObject *> *attr) {
        
        if (attr)
        {
            [self addAttributes:attr range:attrRange];
        } else {
            [self addAttributes:defaultAttrs range:attrRange];
        }
    }];
}

@end
