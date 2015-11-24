//
//  RMVBODataBuffer.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RMVBODataBufferType) {
    RMVBODataBufferTypeStatic = 0,
    RMVBODataBufferTypeDynamic,
    RMVBODataBufferTypeStream
};

@interface RMVBOBuffer : NSObject

@property (nonatomic, readonly) RMVBODataBufferType type;
@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSInteger dataSize;
@property (nullable, nonatomic, readonly) void* buffer;

- (nonnull instancetype)initWithBuffer:(nonnull void*)buffer type:(RMVBODataBufferType)type count:(NSInteger)count dataSize:(NSInteger)dataLenght NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithBuffer:(nonnull void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataLenght;

+ (nonnull instancetype)buffer:(nonnull void*)buffer type:(RMVBODataBufferType)type count:(NSInteger)count dataSize:(NSInteger)dataSize;
+ (nonnull instancetype)buffer:(nonnull void*)buffer count:(NSInteger)count dataSize:(NSInteger)dataSize;
@end


@interface RMVBOIndexBuffer : RMVBOBuffer

@end



