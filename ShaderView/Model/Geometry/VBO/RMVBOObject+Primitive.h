//
//  RMVBOObject+Primitive.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMVBOObject.h"

#import "RMVBOVertexBuffer.h"

@interface RMVBOObject (Primitive)
- (instancetype)cloneVBOWithPrimitiveType:(RMVBOVertexBufferPrimitive)primitive;
@end
