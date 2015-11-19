//
//  RMTestMath.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/19/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "RMMath.h"

@interface RMTestMath : XCTestCase

@end

@implementation RMTestMath



- (void)testIsRMMatrix4x4Equal {
    _RMMatrix4x4 a = {
        1,  2,  3,  4,
        5,  6,  7,  8,
        9,  10, 11, 12,
        13, 14, 15, 16
    };
    
    _RMMatrix4x4 b = {
        1,  2,  3,  4,
        5,  6,  7,  8,
        9,  10, 11, 12,
        13, 14, 15, 16
    };
    
    XCTAssertTrue(isRMMatrix4x4Equal(a, b));
    
    
    b.m11 = 0;
    
    XCTAssertFalse(isRMMatrix4x4Equal(a, b));
}


- (void)testRMMulMatrix4x4_Identity
{
    _RMMatrix4x4 a = {
        1,  2,  3,  4,
        5,  6,  7,  8,
        9,  10, 11, 12,
        13, 14, 15, 16
    };
    
    _RMMatrix4x4 b = kRMIdentityMatrix4x4;
    
    _RMMatrix4x4 c = RMMulMatrix4x4(a,b);
    
    XCTAssertTrue(isRMMatrix4x4Equal(a, c));
    
    c = RMMulMatrix4x4(b,a);
    
    XCTAssertTrue(isRMMatrix4x4Equal(c, a));
}



- (void)testRMMulMatrix4x4_2
{
    _RMMatrix4x4 a = {
        1,  2,  3,  4,
        5,  6,  7,  8,
        9,  10, 11, 12,
        13, 14, 15, 16
    };
    
    _RMMatrix4x4 b = {
        16, 15, 14, 13,
        12, 11, 10, 9,
        8,  7,  6, 5,
        4,  3,  2, 1
    };
    ;
    
    _RMMatrix4x4 c = RMMulMatrix4x4(a,b);
    
    _RMMatrix4x4 d =
    {
        80, 70, 60, 50,
        240, 214, 188, 162,
        400, 358, 316, 274,
        560, 502, 444, 386
    };
    
    
    XCTAssertTrue(isRMMatrix4x4Equal(c, d));
    
    c = RMMulMatrix4x4(b,a);
    
    _RMMatrix4x4 e =
    {
        386, 444, 502, 560,
        274, 316, 358, 400,
        162, 188, 214, 240,
        50,   60,  70, 80
    };
    
    XCTAssertTrue(isRMMatrix4x4Equal(c, e));
}

- (void)testRMMulMatrix4x4_Scalar
{
    _RMMatrix4x4 a = {
        1,  2,  3,  4,
        5,  6,  7,  8,
        9,  10, 11, 12,
        13, 14, 15, 16
    };
    
    _RMMatrix4x4 b = RMMulMatrix4x4ToScalar(a, 2);
    
    _RMMatrix4x4 c = {
        2, 4, 6, 8,
        10, 12, 14, 16,
        18, 20, 22, 24,
        26, 28, 30, 32
    };
    
     XCTAssertTrue(isRMMatrix4x4Equal(b, c));
    
}
@end
