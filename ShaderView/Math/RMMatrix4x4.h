//
//  RMMatrix4x4.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/20/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMatrix.h"

#import "RMMath.h"

@interface RMMatrix4x4 : RMMatrix
{
    _RMMatrix4x4 _matrix;
}
@property (nonatomic, readonly) _RMMatrix4x4 matrix;

- (nullable instancetype)initWithMatrix:(_RMMatrix4x4)matrix;

@end
