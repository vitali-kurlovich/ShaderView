//
//  RMGeometry.m
//  HelloOpenGL
//
//  Created by Vitali Kurlovich on 11/18/15.
//
//

#import "RMVBOObject.h"


@implementation RMVBOObject

- (instancetype)init
{
    return [self initWithVertexData:nil indexData:nil];
}

- (nonnull instancetype)initWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData drawType:(RMVBOObjectDrawType)drawType
{
    self = [super init];
    if (self)
    {
        _drawType = drawType;
        _vertexData = vertexData;
        _indexData = indexData;
    }
    
    return self;
}

- (nonnull instancetype)initWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData
{
    return [self initWithVertexData:vertexData indexData:indexData drawType:RMVBOObjectDrawTypeStatic];
}

+ (nonnull instancetype)objectWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData
{
    return [[[self class] alloc] initWithVertexData:vertexData indexData:indexData];
}

+ (nonnull instancetype)objectWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData drawType:(RMVBOObjectDrawType)drawType
{
    return [[[self class] alloc] initWithVertexData:vertexData indexData:indexData drawType:drawType];
}


- (BOOL)prepareBuffer
{
    return NO;
}

- (void)bindBuffer
{
    
}

@end
