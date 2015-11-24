//
//  RMVBODataField.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RMVBOVertexAttributeType) {
    RMVBOVertexAttributeTypePosition,
    RMVBOVertexAttributeTypeNormal,
    RMVBOVertexAttributeTypeColor,
    RMVBOVertexAttributeTypeUV0,
    RMVBOVertexAttributeTypeUV1
};

typedef NS_ENUM(NSInteger, RMVBOVertexAttributeSize) {
    RMVBOVertexAttributeSize_1 = 1,
    RMVBOVertexAttributeSize_2 = 2,
    RMVBOVertexAttributeSize_3 = 3,
    RMVBOVertexAttributeSize_4 = 4
};


@interface RMVBOVertexAttribute : NSObject
@property (nonatomic, readonly) RMVBOVertexAttributeType type;
@property (nonatomic, readonly) NSInteger offset;
@property (nonatomic, readonly) RMVBOVertexAttributeSize size;
- (nonnull instancetype)initWithType:(RMVBOVertexAttributeType)type offset:(NSInteger)offset size:(RMVBOVertexAttributeSize)numberOfComponents NS_DESIGNATED_INITIALIZER;
+ (nonnull instancetype)attributeWithType:(RMVBOVertexAttributeType)type offset:(NSInteger)offset size:(RMVBOVertexAttributeSize)numberOfComponents;

@end
