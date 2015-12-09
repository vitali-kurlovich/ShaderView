//
//  RMRender.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMRender.h"

#import "RMProgram.h"

@interface RMRender ()
{

}

@end

static RMRenderDevice renderDevice = RMRenderDeviceOpenGL;

@implementation RMRender


+ (nullable Class)renderClassForRenderDevice:(RMRenderDevice)engine
{
    return [self class];
}

- (nullable instancetype)initWithRenderEngine:(RMRenderDevice)engine
{
    return [self init];
}

+ (instancetype)render
{
    return [[[[self class] renderClassForRenderDevice:[RMRender renderDevice]] alloc] init];
}


- (void)draw
{
    
}

- (void)render
{
    [self preRender];
    
    [self draw];
    
    [self postRender];
}

- (void)preRender
{
    [self.program useProgramBegin];
}

- (void)postRender
{
     [self.program useProgramEnd];
}


+ (void)setRenderDevice:(RMRenderDevice)device
{
 
    dispatch_sync(dispatch_get_main_queue(), ^{
        renderDevice = device;
    });
}

+ (RMRenderDevice)renderDevice
{
    RMRenderDevice device = renderDevice;
    return device;
}



@end
