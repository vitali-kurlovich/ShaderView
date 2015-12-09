//
//  RMMeshLoader.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMeshLoader.h"

@implementation RMMeshLoader

- (instancetype)init
{
    return [self initWithFileName:@"" ofType:@""];
}

- (instancetype)initWithFileName:(nonnull NSString*)fileName ofType:(nonnull NSString*)type
{
    if (fileName.length > 0 && type.length > 0)
    {
        self = [super init];
        if (self)
        {
            _fileName = [fileName copy];
            _fileType = [type copy];
        }
        return self;
        
    }
    return nil;
}


+ (NSArray<NSString*>*)supportedType
{
    return @[];
}

@end
