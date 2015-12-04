//
//  RMProceduralMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMProceduralMesh.h"

#import "RMMeshBuilder.h"
#import "RMVBOObject.h"

@interface RMProceduralMesh()
@property (nonatomic, readonly) RMMesh* mesh;
@end

@implementation RMProceduralMesh
@synthesize mesh = _mesh;


- (RMVBOObject*)vbo
{
    return self.mesh.vbo;
}

- (RMMesh*)mesh
{
    if (_mesh == nil)
    {
        RMMeshBuilder* builder = [[RMMeshBuilder alloc] init];
        [self build:builder];
        _mesh = [builder build];
        [_mesh.vbo prepareBuffer];
    }
    
    return _mesh;
}


- (void)build:(RMMeshBuilder*)builder
{

}

- (void)setNeedsRebuild
{
    _mesh = nil;
}

@end
