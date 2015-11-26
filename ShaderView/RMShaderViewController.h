//
//  RMShaderViewController.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/25/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RMShaderView.h"

@interface RMShaderViewController : UIViewController
@property (nullable, readonly) RMShaderView* shaderView;

@property (nullable, nonatomic, weak) id<RMRenderDelegate> renderDelegate;

@end
