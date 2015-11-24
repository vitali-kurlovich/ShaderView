//
//  RMVBOVertexBuffer.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/24/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBOBuffer.h"


typedef NS_ENUM(NSInteger, RMVBOVertexBufferPrimitive) {
    RMVBOVertexBufferPrimitiveTriangle = 0,
    RMVBOVertexBufferPrimitiveTriangleStrip,
    RMVBOVertexBufferPrimitiveTriangleFan,
};


@class RMVBOVertexAttribute;

@interface RMVBOVertexBuffer : RMVBOBuffer
@property (nonatomic, readonly) RMVBOVertexBufferPrimitive primitive;
@property (nullable, nonatomic, copy, readonly) NSArray<RMVBOVertexAttribute*>* attributes;

- (nonnull instancetype)initWithBuffer:(nonnull void*)buffer
                                  type:(RMVBODataBufferType)type
                                 count:(NSInteger)count
                              dataSize:(NSInteger)dataSize
                            attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes
                             primitive:(RMVBOVertexBufferPrimitive)primitive NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithBuffer:(nonnull void*)buffer
                                  type:(RMVBODataBufferType)type
                                 count:(NSInteger)count
                              dataSize:(NSInteger)dataSize
                            attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes;


- (nonnull instancetype)initWithBuffer:(nonnull void*)buffer
                                 count:(NSInteger)count
                              dataSize:(NSInteger)dataSize
                            attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes;


+ (nonnull instancetype)buffer:(nonnull void*)buffer
                          type:(RMVBODataBufferType)type
                         count:(NSInteger)count
                      dataSize:(NSInteger)dataSize
                    attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes
                     primitive:(RMVBOVertexBufferPrimitive)primitive;

+ (nonnull instancetype)buffer:(nonnull void*)buffer
                          type:(RMVBODataBufferType)type
                         count:(NSInteger)count
                      dataSize:(NSInteger)dataSize
                    attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes;

+ (nonnull instancetype)buffer:(nonnull void*)buffer
                         count:(NSInteger)count
                      dataSize:(NSInteger)dataSize
                    attributes:(nullable NSArray<RMVBOVertexAttribute*>*)attributes;


@end