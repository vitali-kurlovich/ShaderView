//
//  RMVBODataBuffer.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBOBuffer.h"

@implementation RMVBOBuffer

- (instancetype)init
{
    void* null_ptr = NULL;
    return [self initWithBuffer:null_ptr count:0 dataSize:0];
}

- (instancetype)initWithBuffer:(void*)buffer type:(RMVBODataBufferType)type count:(NSInteger)count dataSize:(NSInteger)dataSize {
    self = [super init];
    if (self)
    {
        _type = type;
        _count = count;
        _dataSize = dataSize;
        if (RMVBODataBufferTypeStatic == type && buffer)
        {
            _buffer = malloc(_dataSize);
            memcpy(_buffer, buffer, _dataSize);
        } else {
            _buffer = buffer;
        }
    }
    
    return self;
}

- (instancetype)initWithBuffer:(void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize
{
    return [self initWithBuffer:buffer type:RMVBODataBufferTypeStatic count:count dataSize:dataSize];
}


- (void)dealloc
{
    if (self.type == RMVBODataBufferTypeStatic)
    {
        free(_buffer);
    }
}


+ (instancetype)buffer:(void*)buffer type:(RMVBODataBufferType)type count:(NSInteger)count dataSize:(NSInteger)dataSize
{
    return [[[self class] alloc] initWithBuffer:buffer type:type count:count dataSize:dataSize];
}


+ (nonnull instancetype)buffer:(nonnull void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize
{
     return [[[self class] alloc] initWithBuffer:buffer count:count dataSize:dataSize];
}

@end



@implementation RMVBOIndexBuffer

@end


