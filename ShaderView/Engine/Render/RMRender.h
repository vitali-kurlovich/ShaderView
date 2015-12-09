//
//  RMRender.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RMRenderDevice) {
    RMRenderDeviceOpenGL = 0,
    RMRenderDeviceMetal
};

@class RMProgram;

@interface RMRender : NSObject

@property (nullable, nonatomic) RMProgram* program;

+ (nullable Class)renderClassForRenderDevice:(RMRenderDevice)device;

- (void)draw;

- (void)render;
- (void)preRender;
- (void)postRender;


+ (void)setRenderDevice:(RMRenderDevice)device;
+ (RMRenderDevice)renderDevice;

+ (nullable instancetype)render;

@end



