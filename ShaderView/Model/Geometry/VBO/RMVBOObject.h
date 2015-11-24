//
//  RMGeometry.h
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

@import Foundation;

#import "RMMath.h"

typedef struct {
    _RMVector2 position;
    _RMVector2 uv0;
} RMVBO_Mesh_P2_UV02;

typedef struct{
    _RMVector3 position;
    _RMVector2 uv0;
} RMVBO_Mesh_P3_UV02;

typedef struct{
    _RMVector3 position;
    _RMVector2 uv0;
    _RMVector2 uv1;
} RMVBO_Mesh_P3_UV02_UV12;




typedef NS_ENUM(NSInteger, RMVBOObjectDrawType) {
    RMVBOObjectDrawTypeStatic = 0,
    RMVBOObjectDrawTypeDynamic,
    RMVBOObjectDrawTypeStream
};

@class RMVBOVertexDataBuffer, RMVBOIndexDataBuffer;

@interface RMVBOObject : NSObject
@property (nonatomic, readonly, getter=isPrepared) BOOL prepared;
@property (nonatomic, readonly) RMVBOObjectDrawType drawType; // // Posible this property must be in RMVBODataBuffer

@property (nullable,  nonatomic, readonly) RMVBOVertexDataBuffer* vertexData;
@property (nullable,  nonatomic, readonly) RMVBOIndexDataBuffer* indexData;

- (nonnull instancetype)initWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData drawType:(RMVBOObjectDrawType)drawType NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData;


+ (nonnull instancetype)objectWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData drawType:(RMVBOObjectDrawType)drawType;

+ (nonnull instancetype)objectWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData;

- (BOOL)prepareBuffer;
- (void)bindBuffer;

@end
