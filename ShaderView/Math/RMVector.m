//
//  RMVector.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVector.h"

@implementation RMVector

- (instancetype)init
{
    return [self initWithType:RMVectorTypeNone];
}

- (instancetype)initWithType:(RMVectorType)type
{
    if (RMVectorTypeNone == type)
    {
        return nil;
    }
    
    self = [super init];
    if (self)
    {
        _type = type;
    }
    return self;
}


+ (nullable instancetype)vector
{
    return nil;
}

@end
