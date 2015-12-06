//
//  RMTextView.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSourceCodeTextView.h"

#import "RMLineNumberView.h"
#import "RMHighlightingTextStorage.h"

#import "RMHighlightingTheme.h"
#import "RMHighlightingSyntax.h"

static CGFloat const kRMSourceCodeNumberDefaultWidth = 24;

@interface RMSourceCodeTextView () <RMSourceCodeLineNumberViewDataSource>

@property (nonatomic, readonly) RMLineNumberView* lineNumberView;

@property (nonatomic, readonly) RMHighlightingTextStorage* sourceCodeTextStorage;
@end


@implementation RMSourceCodeTextView

@synthesize lineNumberView = _lineNumberView;
@synthesize lineNumberWidth = _lineNumberWidth;

@synthesize lineNumberBackgroundColor = _lineNumberBackgroundColor;

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    RMHighlightingTextStorage* textStorage = nil;
    if (textContainer == nil)
    {
        NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
        
        textContainer = [[NSTextContainer alloc] initWithSize:frame.size];
        [layoutManager addTextContainer:textContainer];
        textStorage = [[RMHighlightingTextStorage alloc] init];
        
        textStorage.theme = [RMHighlightingTheme themeNamed:@"default"];
        textStorage.syntax = [RMHighlightingSyntax syntaxNamed:@"glsl"];
        
        [textStorage addLayoutManager:layoutManager];
    }
    
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self)
    {
        _sourceCodeTextStorage = textStorage;
        [self attachLineNumberView];
        [self configureTextView];
        self.alwaysBounceVertical = YES;
    }
    
    return self;
}


- (void)setSyntax:(RMHighlightingSyntax *)syntax
{
    self.sourceCodeTextStorage.syntax = syntax;
}

- (RMHighlightingSyntax*)syntax
{
    return self.sourceCodeTextStorage.syntax;
}

- (void)setTheme:(RMHighlightingTheme *)theme
{
    self.sourceCodeTextStorage.theme = theme;
}

- (RMHighlightingTheme *)theme
{
    return self.sourceCodeTextStorage.theme;
}


- (void)attachLineNumberView
{
    if (_lineNumberView == nil)
    {
        _lineNumberView = [[RMLineNumberView alloc] initWithFrame:[self frameForSorceCodeLineNumberView]];
        _lineNumberView.backgroundColor = self.lineNumberBackgroundColor;
        _lineNumberView.dataSource = self;
        
        [self addSubview:_lineNumberView];
    }
}


- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset
{
    super.textContainerInset = textContainerInset;
    self.lineNumberView.contentInset = textContainerInset;
}

- (void)configureTextView
{
    UIEdgeInsets textContainerInset = self.textContainerInset;
    textContainerInset.left = self.lineNumberWidth;
    self.textContainerInset = textContainerInset;
}

- (UIColor*)lineNumberBackgroundColor
{
    if (_lineNumberBackgroundColor == nil)
    {
        return self.backgroundColor;
    }
    return _lineNumberBackgroundColor;
}


- (void)setLineNumberBackgroundColor:(UIColor *)lineNumberBackgroundColor
{
    if (_lineNumberBackgroundColor != lineNumberBackgroundColor)
    {
        _lineNumberBackgroundColor = lineNumberBackgroundColor;
        
        self.lineNumberView.backgroundColor = lineNumberBackgroundColor;
    }
}


#pragma mark - RMSourceCodeLineNumberViewDataSource

- (NSInteger)numberOfSourceCodeLinesInLineNumberView:(RMLineNumberView*)numberView
{
    return [self numberOfLines];
}

- (CGRect)sourceCodeLineNumberView:(RMLineNumberView*)numberView rectAtLine:(NSInteger)linenumber
{
    return [self rectForLineAtIndex:linenumber];
}


- (void)setContentOffset:(CGPoint)contentOffset
{
    super.contentOffset = contentOffset;
    
    self.lineNumberView.contentOffset = contentOffset;
    self.lineNumberView.frame = [self frameForSorceCodeLineNumberView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.lineNumberView.frame = [self frameForSorceCodeLineNumberView];
}

- (CGRect)frameForSorceCodeLineNumberView
{
    return CGRectMake(0, CGRectGetMinY(self.bounds), self.lineNumberWidth, CGRectGetHeight(self.frame));
}

- (void)setLineNumberWidth:(CGFloat)lineNumberWidth
{
    
    if (_lineNumberWidth != lineNumberWidth)
    {
        _lineNumberWidth = lineNumberWidth;
        
        [self configureTextView];
        
        [self setNeedsLayout];
    }
}

- (CGFloat)lineNumberWidth
{
    if (_lineNumberWidth <= 0)
    {
        return kRMSourceCodeNumberDefaultWidth;
    }
    return _lineNumberWidth;
}


- (NSUInteger)numberOfLines
{
    NSString *string = self.text;
    
    NSUInteger numberOfLines, index, stringLength = [string length];
    
    for (index = 0, numberOfLines = 0; index < stringLength; numberOfLines++)
    {
        NSRange range = [string lineRangeForRange:NSMakeRange(index, 0)];
        index = NSMaxRange(range);
    }
    
    return numberOfLines;
}


- (NSRange)rangeForTextLineAtIndex:(NSInteger)position
{
    NSString *string = self.text;
    
    NSUInteger numberOfLines, index, stringLength = [string length];
    NSRange range;
    
    for (index = 0, numberOfLines = 0; index < stringLength; numberOfLines++)
    {
        range = [string lineRangeForRange:NSMakeRange(index, 0)];
        index = NSMaxRange(range);
        
        if (numberOfLines == position)
        {
            return range;
        }
    }
    
    return NSMakeRange(0,0);
}

- (CGRect)rectForLineAtIndex:(NSInteger)index
{
    
    NSRange range = [self  rangeForTextLineAtIndex:index];
    
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *start = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    UITextRange *textRange = [self textRangeFromPosition:start toPosition:end];
    CGRect rect = [self firstRectForRange:textRange];
    
    return rect;
}

@end
