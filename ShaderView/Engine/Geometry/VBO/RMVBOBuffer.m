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

static NSString * const kTypeKey = @"type";
static NSString * const kCountKey = @"count";
static NSString * const kSizeKey = @"size";
static NSString * const kBufferKey = @"buffer";


@implementation RMVBOBuffer (Serialization)

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.type forKey:kTypeKey];
    [aCoder encodeInteger:self.count forKey:kCountKey];
    [aCoder encodeInteger:self.dataSize forKey:kSizeKey];
    
    [aCoder encodeBytes:self.buffer length:self.dataSize];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    RMVBODataBufferType type = [aDecoder decodeIntegerForKey:kTypeKey];
    NSInteger count = [aDecoder decodeIntegerForKey:kCountKey];
    NSInteger dataSize = [aDecoder decodeIntegerForKey:kSizeKey];
    
    NSUInteger lenght = 0;
    const uint8_t * buffer = [aDecoder decodeBytesForKey:kBufferKey returnedLength:&lenght];
    
    return [self initWithBuffer:(void*)buffer type:type count:count dataSize:dataSize];
}

@end






