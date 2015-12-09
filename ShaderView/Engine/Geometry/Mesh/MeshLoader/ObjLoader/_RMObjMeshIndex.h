//
//  _RMObjMeshIndex.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface _RMObjMeshIndex : NSObject
@property (nonatomic, readonly) NSNumber* position;
@property (nonatomic, readonly) NSNumber* uv;
@property (nonatomic, readonly) NSNumber* normal;

- (instancetype)initWithPosition:(NSNumber*)position normal:(NSNumber*)normal uv:(NSNumber*)uv;
+ (instancetype)indexWithPosition:(NSNumber*)position normal:(NSNumber*)normal uv:(NSNumber*)uv;

+ (NSArray<_RMObjMeshIndex*>*)scanString:(NSString*)string;

@end