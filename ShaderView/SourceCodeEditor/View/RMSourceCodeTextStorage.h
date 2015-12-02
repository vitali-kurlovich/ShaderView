//
//  RMSourceCodeTextStorage.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/1/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

@class RMSourceCodeTheme;
@class RMSourceCodeSyntax;

@interface RMSourceCodeTextStorage : NSTextStorage
@property (nullable, nonatomic, copy) RMSourceCodeTheme* theme;
@property (nullable, nonatomic, copy) RMSourceCodeSyntax* syntax;
@end
