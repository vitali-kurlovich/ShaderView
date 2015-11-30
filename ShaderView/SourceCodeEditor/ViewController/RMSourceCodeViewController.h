//
//  TextEditorViewController.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMSourceCodeTextView;

@interface RMSourceCodeViewController : UIViewController

@property (nullable, nonatomic, readonly) RMSourceCodeTextView* textView;
@property (nullable, copy) NSString* sorceCode;


- (void)loadTextFileWithName:(nonnull NSString*)name ofType:(nonnull NSString*)type;


@end
