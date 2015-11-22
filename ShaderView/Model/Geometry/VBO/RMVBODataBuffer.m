//
//  RMVBODataBuffer.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBODataBuffer.h"

@implementation RMVBODataBuffer : NSObject

- (instancetype)init
{
    return [self initWithDataType:RMVBODataBufferTypeNone count:0 dataSize:0];
}


- ( instancetype)initWithDataType:(RMVBODataBufferType)type count:(NSInteger)count dataSize:(NSInteger)dataSize
{
    return [self initWithDataType:type buffer:NULL count:count dataSize:dataSize];
}


- (nullable instancetype)initWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize fields:(NSArray<RMVBODataField*>*)fields
{
    return [self initWithDataType:RMVBODataBufferTypeNone buffer:buffer count:count dataSize:dataSize fields:fields];
}

- (instancetype)initWithDataType:(RMVBODataBufferType)type buffer:(const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize
{
    return [self initWithDataType:type buffer:buffer count:count dataSize:dataSize fields:nil];
}

- (instancetype)initWithDataType:(RMVBODataBufferType)type buffer:(const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize fields:(nullable NSArray<RMVBODataField*>*)fields {
    
    if (type == RMVBODataBufferTypeVertex || type ==RMVBODataBufferTypeIndex)
    {
        self = [super init];
        if (self)
        {
            _type = type;
            _count = count;
            _dataSize = dataSize;
            _fields = [fields copy];
            _buffer = malloc(_dataSize);
            memcpy(_buffer, buffer, _dataSize);
        }
        
        return self;
    }
    
    return nil;
}


+ (nullable instancetype)dataWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize fields:(nullable NSArray<RMVBODataField*>*)fields
{
    return [[[self class] alloc] initWithBuffer:buffer count:count dataSize:dataSize fields:fields];
}

+ (nullable instancetype)dataWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize
{
    return [[self class]dataWithBuffer:buffer count:count dataSize:dataSize fields:nil];
}

- (void)dealloc
{
    free(_buffer);
}


@end


@implementation RMVBOVertexDataBuffer

- (nullable instancetype)initWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize fields:(NSArray<RMVBODataField *> *)fields
{
    return [self initWithDataType:RMVBODataBufferTypeVertex buffer:buffer count:count dataSize:dataSize fields:fields];
}

@end

@implementation RMVBOIndexDataBuffer

- (nullable instancetype)initWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize fields:(nullable NSArray<RMVBODataField *> *)fields
{
    return [self initWithDataType:RMVBODataBufferTypeIndex buffer:buffer count:count dataSize:dataSize fields:fields];
}

@end


@implementation RMVBODataField

- (instancetype)init
{
    return [self initWithType:RMVBODataItemTypeIndex offset:0 size:sizeof(int)];
}

- (instancetype)initWithType:(RMVBODataFieldType)type offset:(NSInteger)offset size:(NSInteger)size
{
    self = [super init];
    if (self)
    {
        _type = type;
        _offset = offset;
        _size = size;
    }
    return self;
}

+ (instancetype)dataFieldWithType:(RMVBODataFieldType)type offset:(NSInteger)offset size:(NSInteger)size
{
    return [[[self class] alloc] initWithType:type offset:offset size:size];
}


@end