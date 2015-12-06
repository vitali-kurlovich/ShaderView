//
//  RMLineNumberView.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMLineNumberView.h"

@interface RMLineNumberView ()

@end


@implementation RMLineNumberView


- (void)setContentOffset:(CGPoint)contentOffset
{
    _contentOffset = contentOffset;
   [self setNeedsDisplay];
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_contentInset, contentInset))
    {
        _contentInset = contentInset;
        [self setNeedsLayout];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    NSInteger lines = [self.dataSource numberOfSourceCodeLinesInLineNumberView:self];
    
    CGPoint contentOffset = self.contentOffset;
    CGFloat width = CGRectGetWidth(self.frame);
    
    for (NSInteger line = 0; line < lines; line++)
    {
        CGRect lineRect = [self.dataSource sourceCodeLineNumberView:self rectAtLine:line];
        
        CGFloat y = CGRectGetMinY(lineRect) - contentOffset.y;
        CGFloat height = CGRectGetHeight(lineRect);
       
        CGRect labelRect = CGRectMake(0, y, width, height);
       
        
        NSString* lineNumberString = [@(line+1) stringValue];
        
        [lineNumberString drawInRect:labelRect  withAttributes:nil];
    }
}

@end



