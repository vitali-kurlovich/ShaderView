//
//  RMShaderView.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMShaderView.h"

@import OpenGLES;

@interface RMShaderView ()
@property (nonatomic, readonly) CAEAGLLayer* eaglLayer;
@property (nonatomic, readonly) EAGLContext* context;
@end

@implementation RMShaderView
@synthesize eaglLayer = _eaglLayer;
@synthesize context = _context;

+ (Class)layerClass {
    return [CAEAGLLayer class];
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureDisplayLink];
       
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self configureDisplayLink];
    }
    return self;
}

- (void)render
{
    
}



- (void)_render:(CADisplayLink*)displayLink
{
    [self render];
}

- (void)configureDisplayLink {
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(_render:)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}


- (CAEAGLLayer*)eaglLayer
{
    if (_eaglLayer == nil)
    {
        _eaglLayer = (CAEAGLLayer*) self.layer;
        _eaglLayer.drawableProperties = @{kEAGLDrawablePropertyRetainedBacking:@NO,
                                          kEAGLDrawablePropertyColorFormat:kEAGLColorFormatRGBA8};
        self.contentScaleFactor = [UIScreen mainScreen].scale;
    }
    return _eaglLayer;
}

- (EAGLContext*)context
{
    if (_context == nil)
    {
        EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES3;
        _context = [[EAGLContext alloc] initWithAPI:api];
        if (!_context) {
            NSLog(@"Failed to initialize OpenGLES 3.0 context");
            exit(1);
        }
        
        if (![EAGLContext setCurrentContext:_context]) {
            NSLog(@"Failed to set current OpenGL context");
            exit(1);
        }
    }
    return _context;
}

@end
