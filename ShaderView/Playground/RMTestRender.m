//
//  RMTestRender.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMTestRender.h"

#import "RMProgram.h"


@interface RMTestRender ()
@property (nonatomic, copy, readonly) NSString* vs;
@property (nonatomic, copy, readonly) NSString* fs;
@end


@implementation RMTestRender

@synthesize program = _program;


+ (Class)programClass
{
    return [RMProgram class];
}

- (instancetype)init
{
    return [self initWithVertexShader:@"" fragmentShader:@"" attributes:@[]];
}

- (instancetype)initWithVertexShader:( NSString*)vs fragmentShader:(NSString*)fs attributes:(NSArray<RMVertexAttribute*>*)attributes
{
    self = [super init];
    
    if (self)
    {
        _attributes = [attributes copy];
        
        _vs = [vs copy];
        _fs = [fs copy];
    }
    
    return self;
}

- (RMProgram*)program
{
    if (_program == nil)
    {
        _program = [[[[self class] programClass] alloc] initWithVertexShader:self.vs fragmentShader:self.fs attributes:self.attributes];
    }
    return _program;
}

#pragma mark - RMRenderDelegate <NSObject>

- (void)preRender:(nullable RMRender*)render duration:(rmtime)deltaTime
{
   
    
}

- (void)postRender:(nullable RMRender*)render duration:(rmtime)deltaTime
{
    
}

- (void)render:(nullable RMRender*)render duration:(rmtime)deltaTime
{

}


@end
