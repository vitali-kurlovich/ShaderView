//
//  RMRender.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>




@class RMProgram;

@interface RMRender : NSObject

@property (nullable, nonatomic) RMProgram* program;

- (void)draw;

- (void)render;

- (void)preRender;
- (void)postRender;

@end



