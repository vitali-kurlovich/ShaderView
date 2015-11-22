//
//  RMVBODataBuffer.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RMVBODataBufferType) {
    RMVBODataBufferTypeNone = 0,
    RMVBODataBufferTypeVertex,
    RMVBODataBufferTypeIndex
};


@class RMVBODataField;

@interface RMVBODataBuffer : NSObject

@property (nonatomic, readonly) RMVBODataBufferType type;
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSInteger dataSize;
@property (nullable, nonatomic, readonly) void* buffer;

- (nullable instancetype)initWithDataType:(RMVBODataBufferType)type count:(NSInteger)count dataSize:(NSInteger)dataSize;
- (nullable instancetype)initWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize fields:(nullable NSArray<RMVBODataField*>*)fields;

- (nullable instancetype)initWithDataType:(RMVBODataBufferType)type buffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataLenght;

- (nullable instancetype)initWithDataType:(RMVBODataBufferType)type buffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataLenght fields:(nullable NSArray<RMVBODataField*>*)fields NS_DESIGNATED_INITIALIZER;

+ (nullable instancetype)dataWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize;
+ (nullable instancetype)dataWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize fields:(nullable NSArray<RMVBODataField*>*)fields;

@end


@interface RMVBOIndexDataBuffer : RMVBODataBuffer

@end

@interface RMVBOVertexDataBuffer : RMVBODataBuffer
@property (nullable, nonatomic, copy, readonly) NSArray<RMVBODataField*>* fields;
@end

