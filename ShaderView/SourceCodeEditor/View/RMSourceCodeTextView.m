//
//  RMTextView.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMSourceCodeTextView.h"

#import "RMSourceCodeLineNumberView.h"
#import "RMSourceCodeTextStorage.h"

static CGFloat const kRMSourceCodeNumberDefaultWidth = 24;

@interface RMSourceCodeTextView () <RMSourceCodeLineNumberViewDataSource>

@property (nonatomic, readonly) RMSourceCodeLineNumberView* lineNumberView;
@property (nonatomic, readonly) RMSourceCodeTextStorage* sourceCodeTextStorage;
@end


@implementation RMSourceCodeTextView

@synthesize lineNumberView = _lineNumberView;
@synthesize lineNumberWidth = _lineNumberWidth;

@synthesize lineNumberBackgroundColor = _lineNumberBackgroundColor;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _sourceCodeTextStorage = [[RMSourceCodeTextStorage alloc] init];
        [self attachLineNumberView];
        [self configureTextView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        _sourceCodeTextStorage = [[RMSourceCodeTextStorage alloc] init];
        [self attachLineNumberView];
        [self configureTextView];
    }
    return self;
}

- (NSTextStorage*)textStorage
{
    return self.sourceCodeTextStorage;
}

- (void)attachLineNumberView
{
    if (_lineNumberView == nil)
    {
        _lineNumberView = [[RMSourceCodeLineNumberView alloc] initWithFrame:[self frameForSorceCodeLineNumberView]];
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

- (NSInteger)numberOfSourceCodeLinesInLineNumberView:(RMSourceCodeLineNumberView*)numberView
{
    return [self numberOfLines];
}

- (CGRect)sourceCodeLineNumberView:(RMSourceCodeLineNumberView*)numberView rectAtLine:(NSInteger)linenumber
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
