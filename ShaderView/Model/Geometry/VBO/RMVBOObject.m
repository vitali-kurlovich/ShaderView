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

- (nonnull instancetype)initWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData
{
    self = [super init];
    if (self)
    {
        _vertexData = vertexData;
        _indexData = indexData;
    }
    
    return self;
}


+ (nonnull instancetype)objectWithVertexData:(nullable RMVBOVertexDataBuffer*)vertexData indexData:(nullable RMVBOIndexDataBuffer*)indexData
{
    return [[[self class] alloc] initWithVertexData:vertexData indexData:indexData];
}


- (BOOL)prepareBuffer
{
    return NO;
}

- (void)bindBuffer
{
    
}


- (void)setNeedsToRefrashBuffer
{
    
}



@end
