//
//  RMProceduralMeshLoader.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/10/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMProceduralMeshLoader.h"

#import "RMMesh.h"

@implementation RMProceduralMeshLoader

@synthesize mesh = _mesh;

+ (NSArray<NSString*>*)supportedType
{
    return @[@"rmpmesh"];
}


- (RMMesh*)mesh
{
    if (_mesh == nil)
    {
        NSString* path = [[NSBundle mainBundle] pathForResource:self.fileName ofType:self.fileType];
        _mesh = [[RMMesh alloc] initWithContentsOfFile:path];
    }
    return _mesh;
}

@end
