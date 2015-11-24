//
//  RMVBODataField.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBOVertexAttributes.h"

@implementation RMVBOVertexAttributes

- (instancetype)init
{
    return [self initWithType:RMVBOVertexAttributesTypePosition offset:0 numberOfComponents:RMVBODataFieldComponentsNumber4];
}

- (instancetype)initWithType:(RMVBOVertexAttributesType)type offset:(NSInteger)offset numberOfComponents:(RMVBODataFieldComponentsNumber)numberOfComponents
{
    self = [super init];
    if (self)
    {
        _type = type;
        _offset = offset;
        _numberOfComponents = numberOfComponents;
    }
    return self;
}

+ (instancetype)dataFieldWithType:(RMVBOVertexAttributesType)type offset:(NSInteger)offset numberOfComponents:(RMVBODataFieldComponentsNumber)numberOfComponents
{
    return [[[self class] alloc] initWithType:type offset:offset numberOfComponents:numberOfComponents];
}


@end