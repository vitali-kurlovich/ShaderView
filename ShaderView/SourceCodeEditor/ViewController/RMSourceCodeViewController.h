//
//  TextEditorViewController.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/21/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMSourceCodeViewController : UIViewController
@property (nullable, copy, readonly) NSString* sorceCode;

- (void)loadTextFileWithName:(nonnull NSString*)name ofType:(nonnull NSString*)type;


@end
