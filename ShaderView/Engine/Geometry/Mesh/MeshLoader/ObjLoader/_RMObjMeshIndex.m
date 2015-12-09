//
//  _RMObjMeshIndex.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "_RMObjMeshIndex.h"

@implementation _RMObjMeshIndex
- (instancetype)initWithPosition:(NSNumber*)position normal:(NSNumber*)normal uv:(NSNumber*)uv
{
    self = [super init];
    
    if (self)
    {
        _position = position;
        _normal = normal;
        _uv = uv;
    }
    
    return self;
}

+ (instancetype)indexWithPosition:(NSNumber*)position normal:(NSNumber*)normal uv:(NSNumber*)uv
{
    return [[[self class] alloc] initWithPosition:position normal:normal uv:uv];
}

+ (instancetype)indexWithPosition:(NSNumber*)position normal:(NSNumber*)normal
{
    return [[[self class] alloc] initWithPosition:position normal:normal uv:nil];
}

+ (NSArray<_RMObjMeshIndex*>*)scanString:(NSString*)string
{
    
    if (![string hasPrefix:@"f "]) return nil;
    
    NSScanner* scanner = [NSScanner scannerWithString:string];
    
    scanner.scanLocation = 1;
    NSMutableArray* result = [NSMutableArray arrayWithCapacity:4];
    while (![scanner isAtEnd]) {
        
        
        
        NSInteger pos = 0;
        NSNumber* position = nil;
        
        if ([scanner scanInteger:&pos])
        {
            position = @(pos);
        }
        
        NSInteger loc = scanner.scanLocation;
        loc++;
        scanner.scanLocation = loc;
        
        
        NSInteger uv = 0;
        NSNumber* uv0 = nil;
        
        if ([scanner scanInteger:&uv])
        {
            uv0 = @(uv);
        }
        
        loc = scanner.scanLocation;
        loc++;
        scanner.scanLocation = loc;
        
        NSInteger norm = 0;
        NSNumber* normal = nil;
        
        if ([scanner scanInteger:&norm])
        {
            normal = @(norm);
        }
        
        [result addObject:[_RMObjMeshIndex indexWithPosition:position normal:normal uv:uv0]];
        
    }
    return result;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    
    return [self isEqualToObjMeshIndex:object];
}

- (BOOL)isEqualToObjMeshIndex:(_RMObjMeshIndex*)index
{
    if (index == nil) return NO;
    
    return
    (self.position == index.position || [self.position isEqual:index.position]) &&
    (self.normal == index.normal || [self.normal isEqual:index.normal]) &&
    (self.uv == index.uv || [self.uv isEqual:index.uv]);
}

@end