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

@implementation RMRender

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



@end
