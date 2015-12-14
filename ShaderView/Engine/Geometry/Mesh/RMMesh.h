//
//  RMMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMVBOObject;

@protocol RMMeshDelegate;

@interface RMMesh : NSObject
@property (nullable, nonatomic, readonly) RMVBOObject* vbo;
@property (nonatomic, weak) id<RMMeshDelegate> delegate;

+ (nonnull instancetype)mesh;
+ (nonnull instancetype)meshWithVBO:(nullable RMVBOObject*)vbo;

- (nonnull instancetype)initWithVBO:(nullable RMVBOObject*)vbo;

@end


@interface RMMesh (Loading)
+ (nullable instancetype)meshNamed:(nonnull NSString*)name;
@end

@interface RMMesh (Serialization)<NSCoding>
- (BOOL)writeToFile:(nonnull NSString*)filePath;
- (nullable instancetype)initWithContentsOfFile:(nonnull NSString*)filePath;
@end


@protocol RMMeshDelegate <NSObject>
@optional
- (void)mesh:(nonnull RMMesh*)mesh vboDidChange:(nullable RMVBOObject*)vbo;

@end