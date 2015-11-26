//
//  RMLineNumberView.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RMSourceCodeLineNumberViewDataSource;

@interface RMSourceCodeLineNumberView : UIView
@property (nonatomic) CGPoint contentOffset;
@property (nonatomic) UIEdgeInsets contentInset;

@property (nonatomic, weak) id<RMSourceCodeLineNumberViewDataSource> dataSource;


@end


@protocol RMSourceCodeLineNumberViewDataSource <NSObject>

- (NSInteger)numberOfSourceCodeLinesInLineNumberView:(RMSourceCodeLineNumberView*)numberView;
- (CGRect)sourceCodeLineNumberView:(RMSourceCodeLineNumberView*)numberView rectAtLine:(NSInteger)linenumber;

@end