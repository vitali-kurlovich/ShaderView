//
//  RMVertexAttribute.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVertexAttribute.h"

@implementation RMVertexAttribute
- (instancetype)init
{
    return [self initWithName:@"" attribute:RMVBOVertexAttributesTypePosition];
}

- (nonnull instancetype)initWithName:(NSString*)name attribute:(RMVBOVertexAttributesType)attribute {
    
    self = [super init];
    if (self)
    {
        _attribute = attribute;
        _name = [name copy];
    }
    return self;
}

+ (nonnull instancetype)attributeWithName:(nonnull NSString*)name attribute:(RMVBOVertexAttributesType)attribute
{
    return [[[self class] alloc] initWithName:name attribute:attribute];
}
@end
