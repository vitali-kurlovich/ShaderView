//
//  RMVBOVertexBuffer.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/24/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBOVertexBuffer.h"


@implementation RMVBOVertexBuffer

- (instancetype)initWithBuffer:( void*)buffer
                          type:(RMVBODataBufferType)type
                         count:(NSInteger)count
                      dataSize:(NSInteger)dataSize
                    attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes
                     primitive:(RMVBOVertexBufferPrimitive)primitive
{
    self = [super initWithBuffer:buffer type:type count:count dataSize:dataSize];
    if (self)
    {
        _attributes = [attributes copy];
        _primitive = primitive;
    }
    return self;
}

- (instancetype)initWithBuffer:( void*)buffer
                          type:(RMVBODataBufferType)type
                         count:(NSInteger)count
                      dataSize:(NSInteger)dataSize
                    attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes
{
    return [self initWithBuffer:buffer type:type count:count dataSize:dataSize attributes:attributes primitive:RMVBOVertexBufferPrimitiveTriangle];
}

- ( instancetype)initWithBuffer:(void*)buffer type:(RMVBODataBufferType)type count:(NSInteger)count dataSize:(NSInteger)dataSize
{
    return [self initWithBuffer:buffer type:type count:count dataSize:dataSize attributes:nil];
}

- ( instancetype)initWithBuffer:(void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes
{
    return [self initWithBuffer:buffer type:RMVBODataBufferTypeStatic count:count dataSize:dataSize attributes:attributes];
}


+ (nonnull instancetype)buffer:(nonnull void*)buffer
                          type:(RMVBODataBufferType)type
                         count:(NSInteger)count
                      dataSize:(NSInteger)dataSize
                    attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes
                     primitive:(RMVBOVertexBufferPrimitive)primitive
{
    return [[[self class] alloc] initWithBuffer:buffer type:type count:count dataSize:dataSize attributes:attributes primitive:primitive];
}

+ (nonnull instancetype)buffer:(nonnull void*)buffer
                          type:(RMVBODataBufferType)type
                         count:(NSInteger)count
                      dataSize:(NSInteger)dataSize
                    attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes
{
    return [[[self class] alloc] initWithBuffer:buffer type:type count:count dataSize:dataSize attributes:attributes];
}

+ (nonnull instancetype)buffer:(nonnull void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes
{
    return [[[self class] alloc] initWithBuffer:buffer count:count dataSize:dataSize attributes:attributes];
}


@end