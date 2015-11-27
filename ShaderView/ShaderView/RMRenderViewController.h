//
//  RMRenderViewController.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/27/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

@import UIKit;

#import "RMCommon.h"
#import "RMRenderView.h"


@interface RMRenderViewController : UIViewController<RMRenderViewDelegate>

- (RMRenderView*)renderView;

@end
