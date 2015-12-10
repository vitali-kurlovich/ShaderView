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


static NSString * const kTypeKey = @"type";
static NSString * const kCountKey = @"count";
static NSString * const kSizeKey = @"size";
static NSString * const kBufferKey = @"buffer";

static NSString * const kPrimitiveKey = @"primitive";
static NSString * const kAttrKey = @"attr";

@implementation RMVBOVertexBuffer (Serialization)

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.type forKey:kTypeKey];
    [aCoder encodeInteger:self.count forKey:kCountKey];
    [aCoder encodeInteger:self.dataSize forKey:kSizeKey];
 
    [aCoder encodeInteger:self.primitive forKey:kPrimitiveKey];
    [aCoder encodeObject:self.attributes forKey:kAttrKey];
    
    [aCoder encodeBytes:self.buffer length:self.dataSize];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    RMVBODataBufferType type = [aDecoder decodeIntegerForKey:kTypeKey];
    NSInteger count = [aDecoder decodeIntegerForKey:kCountKey];
    NSInteger dataSize = [aDecoder decodeIntegerForKey:kSizeKey];
    RMVBOVertexBufferPrimitive primitive = [aDecoder decodeIntegerForKey:kPrimitiveKey];
    NSArray<RMVBOVertexAttribute*>* attributes = [aDecoder decodeObjectForKey:kAttrKey];
    
    NSUInteger lenght = 0;
    const uint8_t * buffer = [aDecoder decodeBytesForKey:kBufferKey returnedLength:&lenght];
    
    return [self initWithBuffer:(void*)buffer type:type count:count dataSize:dataSize attributes:attributes primitive:primitive];
}

@end
