//
//  RMGeometry.h
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

@import Foundation;

#import "RMMath.h"


@class RMVBOVertexBuffer, RMVBOIndexBuffer;

@interface RMVBOObject : NSObject

@property (nullable,  nonatomic, readonly) RMVBOVertexBuffer* vertexBuffer;
@property (nullable,  nonatomic, readonly) RMVBOIndexBuffer* indexBuffer;

- (nonnull instancetype)initWithVertexData:(nonnull RMVBOVertexBuffer*)vertexData indexData:(nullable RMVBOIndexBuffer*)indexData NS_DESIGNATED_INITIALIZER;

+ (nonnull instancetype)objectWithVertexData:(nonnull RMVBOVertexBuffer*)vertexData indexData:(nullable RMVBOIndexBuffer*)indexData;


@end


@interface RMVBOObject (Serialization)<NSCoding>

@end