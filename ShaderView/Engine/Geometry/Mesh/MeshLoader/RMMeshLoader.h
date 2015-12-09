//
//  RMMeshLoader.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMMesh;

@interface RMMeshLoader : NSObject
@property (nullable, nonatomic, copy, readonly) NSString* fileName;
@property (nullable, nonatomic, copy, readonly) NSString* fileType;

@property (nullable, readonly) RMMesh* mesh;

+ (nonnull NSArray<NSString*>*)supportedType;

- (nullable instancetype)initWithFileName:(nonnull NSString*)fileName ofType:(nonnull NSString*)type NS_DESIGNATED_INITIALIZER;


@end
