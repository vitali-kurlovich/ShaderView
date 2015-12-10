//
//  RMMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//



#import "RMMesh.h"



@implementation RMMesh

+ (nonnull instancetype)mesh
{
    return [[[self class] alloc] init];
}


+ (nonnull instancetype)meshWithVBO:(RMVBOObject*)vbo
{
    return [[[self class] alloc] initWithVBO:vbo];
}


- (instancetype)initWithVBO:(RMVBOObject*)vbo
{
    self = [super init];
    if (self)
    {
        _vbo = vbo;
    }
    return self;
}


- (instancetype)init
{
    return [self initWithVBO:nil];
}

@end


static NSString * const kVBOBufferKey = @"vbo";

@implementation RMMesh (Serialization)

- (BOOL)writeToFile:(NSString*)filePath
{
     return [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}

- (instancetype)initWithContentsOfFile:(NSString*)filePath
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}


#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.vbo forKey:kVBOBufferKey];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    RMVBOObject* vbo = [aDecoder decodeObjectForKey:kVBOBufferKey];
    return [self initWithVBO:vbo];
}



@end
