//
//  RMVBOIndexBuffer.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/8/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBOIndexBuffer.h"

@implementation RMVBOIndexBuffer

- (instancetype)initWithBuffer:(void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize generateWireframe:(BOOL)wireframe
{
    if (wireframe)
    {
        
    }
    return [self initWithBuffer:buffer type:RMVBODataBufferTypeStatic count:count dataSize:dataSize];
}
@end
