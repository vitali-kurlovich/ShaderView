//
//  RMMeshBuilder.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/2/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMeshBuilder.h"

#import "RMVector.h"

#import "RMTriangle3D.h"
#import "RMQuad3D.h"


@interface RMMeshBuilder ()

@property (nonatomic,  readonly) NSMutableArray<RMTriangle3D*>* triangles;
@end

@implementation RMMeshBuilder


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _triangles = [NSMutableArray array];
    }
    return self;
}

- (nonnull RMMesh*)build
{
    
    
    
    return nil;
}

- (void)reset
{
     _triangles = [NSMutableArray array];
}

- (void)appendTriangle:(RMTriangle3D*)triangle
{
    [self.triangles addObject:triangle];
}

- (void)appendQuad:(RMQuad3D*)quad
{
    [self appendTriangle:[RMTriangle3D triangleWithPointA:quad.a b:quad.b c:quad.c]];
    [self appendTriangle:[RMTriangle3D triangleWithPointA:quad.c b:quad.d c:quad.a]];;
}


@end
