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


typedef NS_ENUM(NSInteger, RMVBODataFieldType) {
    RMVBODataItemTypeIndex = 0,
    RMVBODataItemTypePosition,
    RMVBODataItemTypeNormal,
    RMVBODataItemTypeColor,
    RMVBODataItemTypeUV0,
    RMVBODataItemTypeUV1
};

@interface RMVBODataField : NSObject
@property (nonatomic, readonly) RMVBODataFieldType type;
@property (nonatomic, readonly) NSInteger offset;
@property (nonatomic, readonly) NSInteger size;
- (nonnull instancetype)initWithType:(RMVBODataFieldType)type offset:(NSInteger)offset size:(NSInteger)size NS_DESIGNATED_INITIALIZER;
+ (nonnull instancetype)dataFieldWithType:(RMVBODataFieldType)type offset:(NSInteger)offset size:(NSInteger)size;

@end

@interface RMVBODataBuffer : NSObject
@property (nullable, nonatomic, copy, readonly) NSArray<RMVBODataField*>* fields;
@property (nonatomic, readonly) RMVBODataBufferType type;
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSInteger dataLenght;
@property (nullable, nonatomic, readonly) void* buffer;

- (nullable instancetype)initWithDataType:(RMVBODataBufferType)type count:(NSInteger)count dataLenght:(NSInteger)dataLenght;
- (nullable instancetype)initWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataLenght:(NSInteger)dataLenght fields:(nullable NSArray<RMVBODataField*>*)fields;

- (nullable instancetype)initWithDataType:(RMVBODataBufferType)type buffer:(nullable const void*)buffer count:(NSInteger)count dataLenght:(NSInteger)dataLenght;

- (nullable instancetype)initWithDataType:(RMVBODataBufferType)type buffer:(nullable const void*)buffer count:(NSInteger)count dataLenght:(NSInteger)dataLenght fields:(nullable NSArray<RMVBODataField*>*)fields NS_DESIGNATED_INITIALIZER;

+ (nullable instancetype)dataWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataLenght:(NSInteger)dataLenght;
+ (nullable instancetype)dataWithBuffer:(nullable const void*)buffer count:(NSInteger)count dataLenght:(NSInteger)dataLenght fields:(nullable NSArray<RMVBODataField*>*)fields;

@end


@interface RMVBOIndexDataBuffer : RMVBODataBuffer

@end

@interface RMVBOVertexDataBuffer : RMVBODataBuffer

@end

