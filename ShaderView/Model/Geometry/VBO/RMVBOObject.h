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


@class RMVBOVertexBuffer, RMVBOIndexBuffer;

@interface RMVBOObject : NSObject
@property (nonatomic, readonly, getter=isPrepared) BOOL prepared;


@property (nullable,  nonatomic, readonly) RMVBOVertexBuffer* vertexBuffer;
@property (nullable,  nonatomic, readonly) RMVBOIndexBuffer* indexBuffer;



- (nonnull instancetype)initWithVertexData:(nonnull RMVBOVertexBuffer*)vertexData indexData:(nullable RMVBOIndexBuffer*)indexData NS_DESIGNATED_INITIALIZER;

+ (nonnull instancetype)objectWithVertexData:(nonnull RMVBOVertexBuffer*)vertexData indexData:(nullable RMVBOIndexBuffer*)indexData;

- (BOOL)prepareBuffer;
- (void)bindBuffer;

- (void)setNeedsToRefrashBuffers;

@end
