//
//  RMVBODataField.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBOVertexAttribute.h"

@implementation RMVBOVertexAttribute

- (instancetype)init
{
    return [self initWithType:RMVBOVertexAttributeTypePosition offset:0 size:RMVBOVertexAttributeSize_4];
}

- (instancetype)initWithType:(RMVBOVertexAttributeType)type offset:(NSInteger)offset size:(RMVBOVertexAttributeSize)numberOfComponents
{
    self = [super init];
    if (self)
    {
        _type = type;
        _offset = offset;
        _size = numberOfComponents;
    }
    return self;
}

+ (instancetype)attributeWithType:(RMVBOVertexAttributeType)type offset:(NSInteger)offset size:(RMVBOVertexAttributeSize)numberOfComponents
{
    return [[[self class] alloc] initWithType:type offset:offset size:numberOfComponents];
}


@end