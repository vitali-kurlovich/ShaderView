//
//  RMObjMeshLoaderTest.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "_RMObjMeshIndex.h"

@interface RMObjMeshLoaderTest : XCTestCase

@end

@implementation RMObjMeshLoaderTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testObjMeshIndexScan {
    
    NSArray* array = [_RMObjMeshIndex scanString:@"f 1/2/3"];
    
    NSArray* test  = @[[_RMObjMeshIndex indexWithPosition:@(1) normal:@(3) uv:@(2)]];
    
    XCTAssertEqualObjects(array, test);
    
    array = [_RMObjMeshIndex scanString:@"f 1//3"];
    test  = @[[_RMObjMeshIndex indexWithPosition:@(1) normal:@(3) uv:nil]];
    
    
    XCTAssertEqualObjects(array, test);
    
    
    array = [_RMObjMeshIndex scanString:@"f 1/2/3 4/5/6"];
    
    test  = @[[_RMObjMeshIndex indexWithPosition:@(1) normal:@(3) uv:@(2)], [_RMObjMeshIndex indexWithPosition:@(4) normal:@(6) uv:@(5)]];
    
     XCTAssertEqualObjects(array, test);
}


@end
