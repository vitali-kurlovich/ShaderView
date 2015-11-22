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
@end