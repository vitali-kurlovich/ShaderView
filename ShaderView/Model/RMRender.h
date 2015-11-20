//
//  RMRender.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef double rmtime;

@interface RMRender : NSObject
- (void)render:(rmtime)deltaTime;
@end
