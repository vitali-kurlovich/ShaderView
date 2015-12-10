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
    return [self initWithType:RMVBOVertexAttributeTypeNone offset:0 size:RMVBOVertexAttributeSize_0];
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

static NSString * const kTypeKey = @"type";
static NSString * const kOffsetKey = @"offset";
static NSString * const kSizeKey = @"size";

@implementation RMVBOVertexAttribute  (Serialization)

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeInteger:self.type forKey:kTypeKey];
    [aCoder encodeInteger:self.offset forKey:kOffsetKey];
    [aCoder encodeInteger:self.size forKey:kSizeKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    RMVBOVertexAttributeType type =[aDecoder decodeIntegerForKey:kTypeKey];
    NSInteger offset = [aDecoder decodeIntegerForKey:kOffsetKey];
    RMVBOVertexAttributeSize size = [aDecoder decodeIntegerForKey:kSizeKey];
    
    return [self initWithType:type offset:offset size:size];
}
@end