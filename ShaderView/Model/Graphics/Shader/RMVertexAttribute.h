//
//  RMVertexAttribute.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBODataField.h"

@interface RMVertexAttribute : NSObject
@property (nonatomic, readonly) RMVBODataFieldType attribute;
@property (nonnull, nonatomic, copy, readonly) NSString* name;

- (nonnull instancetype)initWithName:(nonnull NSString*)name attribute:(RMVBODataFieldType)attribute NS_DESIGNATED_INITIALIZER;
+ (nonnull instancetype)attributeWithName:(nonnull NSString*)name attribute:(RMVBODataFieldType)attribute;
@end