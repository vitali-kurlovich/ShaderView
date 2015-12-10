//
//  RMMesh+Loading.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMesh.h"

#import "RMObjMeshLoader.h"
#import "RMBinMeshLoader.h"


@interface _RMMeshCache : NSObject
@property (nonatomic) NSCache* cache;
@end

@implementation _RMMeshCache

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _cache = [[NSCache alloc] init];
    }
        
    return self;
}

+ (instancetype)cache
{
    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (RMMesh*)meshNamed:(nonnull NSString*)name
{
    RMMesh* mesh = [self.cache objectForKey:name];
    
    if (mesh)
    {
        return mesh;
    }
    
    if (name.length > 0)
    {
        NSString* fileType = nil;
        
        for (NSString* type in [RMBinMeshLoader supportedType]) {
            NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:type];
            if (path)
            {
                fileType = type;
                break;
            }
        }
        
        if (fileType)
        {
            mesh = [[[RMBinMeshLoader alloc] initWithFileName:name ofType:fileType] mesh];
            [self.cache setObject:mesh forKey:name];
            return mesh;
        }
        
        
        for (NSString* type in [RMObjMeshLoader supportedType]) {
            NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:type];
            if (path)
            {
                fileType = type;
                break;
            }
        }
        
        if (fileType)
        {
            mesh = [[[RMObjMeshLoader alloc] initWithFileName:name ofType:fileType] mesh];
            [self.cache setObject:mesh forKey:name];
            return mesh;
        }
    }
    
    return nil;
}

@end

@implementation RMMesh (Loading)

+ (nullable instancetype)meshNamed:(nonnull NSString*)name
{
    return [[_RMMeshCache cache] meshNamed:name];
}

@end
