//
//  RMVBODataField.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, RMVBOVertexAttributeType) {
    RMVBOVertexAttributeTypeNone      = 0,
    RMVBOVertexAttributeTypePosition  = 1 << 1,
    RMVBOVertexAttributeTypeNormal    = 1 << 2,
    RMVBOVertexAttributeTypeColor     = 1 << 3,
    RMVBOVertexAttributeTypeUV0       = 1 << 4,
    RMVBOVertexAttributeTypeUV1       = 1 << 5,
    RMVBOVertexAttributeTypeUV2       = 1 << 6,
    RMVBOVertexAttributeTypeUV3       = 1 << 7
};

typedef NS_ENUM(NSInteger, RMVBOVertexAttributeSize) {
    RMVBOVertexAttributeSize_0 = 0,
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
