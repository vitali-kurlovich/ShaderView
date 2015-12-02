//
//  RMSourceCodeTextStorage.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

@class RMHighlightingTheme;
@class RMHighlightingSyntax;

@interface RMHighlightingTextStorage : NSTextStorage
@property (nullable, nonatomic, copy) RMHighlightingTheme* theme;
@property (nullable, nonatomic, copy) RMHighlightingSyntax* syntax;
@end
