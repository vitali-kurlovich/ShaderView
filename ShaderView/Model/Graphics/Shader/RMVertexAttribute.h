//
//  RMVertexAttribute.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBOVertexAttributes.h"

@interface RMVertexAttribute : NSObject
@property (nonatomic, readonly) RMVBOVertexAttributesType attribute;
@property (nonnull, nonatomic, copy, readonly) NSString* name;

- (nonnull instancetype)initWithName:(nonnull NSString*)name attribute:(RMVBOVertexAttributesType)attribute NS_DESIGNATED_INITIALIZER;
+ (nonnull instancetype)attributeWithName:(nonnull NSString*)name attribute:(RMVBOVertexAttributesType)attribute;
@end