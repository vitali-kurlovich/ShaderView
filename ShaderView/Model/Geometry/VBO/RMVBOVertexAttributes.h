//
//  RMVBODataField.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RMVBOVertexAttributesType) {
    RMVBOVertexAttributesTypePosition,
    RMVBOVertexAttributesTypeNormal,
    RMVBOVertexAttributesTypeColor,
    RMVBOVertexAttributesTypeUV0,
    RMVBOVertexAttributesTypeUV1
};

typedef NS_ENUM(NSInteger, RMVBODataFieldComponentsNumber) {
    RMVBODataFieldComponentsNumber1 = 1,
    RMVBODataFieldComponentsNumber2 = 2,
    RMVBODataFieldComponentsNumber3 = 3,
    RMVBODataFieldComponentsNumber4 = 4
};


@interface RMVBOVertexAttributes : NSObject
@property (nonatomic, readonly) RMVBOVertexAttributesType type;
@property (nonatomic, readonly) NSInteger offset;
@property (nonatomic, readonly) RMVBODataFieldComponentsNumber numberOfComponents;
- (nonnull instancetype)initWithType:(RMVBOVertexAttributesType)type offset:(NSInteger)offset numberOfComponents:(RMVBODataFieldComponentsNumber)numberOfComponents NS_DESIGNATED_INITIALIZER;
+ (nonnull instancetype)dataFieldWithType:(RMVBOVertexAttributesType)type offset:(NSInteger)offset numberOfComponents:(RMVBODataFieldComponentsNumber)numberOfComponents;

@end
