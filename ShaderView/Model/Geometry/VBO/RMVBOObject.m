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
    RMVBOVertexBuffer* vb = nil;
    return [self initWithVertexData:vb indexData:nil];
}

- (nonnull instancetype)initWithVertexData:(RMVBOVertexBuffer*)vertexData indexData:( RMVBOIndexBuffer*)indexData
{
    self = [super init];
    if (self)
    {
        _vertexBuffer = vertexData;
        _indexBuffer = indexData;
    }
    
    return self;
}


+ (nonnull instancetype)objectWithVertexData:(RMVBOVertexBuffer*)vertexData indexData:(RMVBOIndexBuffer*)indexData
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


- (void)setNeedsToRefrashBuffers
{
    
}



@end
