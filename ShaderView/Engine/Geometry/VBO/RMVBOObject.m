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

- (nonnull instancetype)initWithVertexData:(RMVBOVertexBuffer*)vertexData indexData:(RMVBOIndexBuffer*)indexData
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

@end


static NSString * const kVertexBufferKey = @"vertexBuffer";
static NSString * const kIndexBufferKey = @"indexBuffer";

@implementation RMVBOObject (Serialization)

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.vertexBuffer forKey:kVertexBufferKey];
    [aCoder encodeObject:self.indexBuffer forKey:kIndexBufferKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    RMVBOVertexBuffer* vb = [aDecoder decodeObjectForKey:kVertexBufferKey];
    RMVBOIndexBuffer* ib = [aDecoder decodeObjectForKey:kIndexBufferKey];
    
    return [self initWithVertexData:vb indexData:ib];
}

@end
