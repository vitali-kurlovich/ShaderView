//
//  RMObjMeshLoader.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/9/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMObjMeshLoader.h"

#import "RMMeshBuilder.h"

#import "RMMath.h"

#import "_RMObjMeshIndex.h"
#import "RMMeshVertex3D.h"

@interface RMObjMeshLoader ()

@end

@implementation RMObjMeshLoader

@synthesize mesh = _mesh;

- (RMMesh*)mesh
{
    if (_mesh == nil)
    {
        _mesh = [self loadMesh];
    }
    return _mesh;
}

+ (NSArray<NSString*>*)supportedType
{
    return @[@"obj"];
}

- (RMMesh*)loadMesh
{
    NSString* path = [[NSBundle mainBundle] pathForResource:self.fileName ofType:self.fileType];
    
    if (path.length < 1)
    {
        return nil;
    }
    
    NSError* error;
    NSString* textString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    if (!textString)
    {
        NSLog(@"Error loading file: %@", error.localizedDescription);
    }
    
    return [self parseObjFile:textString];
}



- (RMMesh*)parseObjFile:(NSString*)content
{
    __block NSMutableArray<RMVector3*>* positions = [NSMutableArray array];
    __block NSMutableArray<RMVector3*>* normals = [NSMutableArray array];
    
    __block NSMutableArray<RMVector2*>* uvs = [NSMutableArray array];
    
    __block NSMutableArray<NSArray<_RMObjMeshIndex*>*>* indexes = [NSMutableArray array];
    
    
    [content enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        
        if ([line hasPrefix:@"#"]) return ;
        
        if ([line hasPrefix:@"v "]) {
            NSScanner* scaner = [NSScanner scannerWithString:line];
            scaner.scanLocation = 2;
            float x = 0;
            float y = 0;
            float z = 0;
            [scaner scanFloat:&x];
            [scaner scanFloat:&y];
            [scaner scanFloat:&z];
            
            [positions addObject:[RMVector3 vectorWithX:x y:y z:z]];
        }
        else if ([line hasPrefix:@"vt "]) {
            NSScanner* scaner = [NSScanner scannerWithString:line];
            scaner.scanLocation = 3;
            float x = 0;
            float y = 0;
            
            [scaner scanFloat:&x];
            [scaner scanFloat:&y];
            
            [uvs addObject:[RMVector2 vectorWithX:x y:y]];
        }
        
        else if ([line hasPrefix:@"vn "]) {
            NSScanner* scaner = [NSScanner scannerWithString:line];
            scaner.scanLocation = 3;
            float x = 0;
            float y = 0;
            float z = 0;
            [scaner scanFloat:&x];
            [scaner scanFloat:&y];
            [scaner scanFloat:&z];
            
            [normals addObject:[RMVector3 vectorWithX:x y:y z:z]];
        }
        else if ([line hasPrefix:@"f "]) {
            
            NSArray<_RMObjMeshIndex*>* face =  [_RMObjMeshIndex scanString:line];
            if (face)
            {
                [indexes addObject:face];
            }
        }
    }];
    
    RMVBOVertexAttributeType format = RMVBOVertexAttributeTypePosition;
    if (normals.count > 0)
    {
        format |= RMVBOVertexAttributeTypeNormal;
    } else {
        normals = nil;
    }
    
    if (uvs.count > 0)
    {
        format |= RMVBOVertexAttributeTypeUV0;
    } else {
        uvs = nil;
    }
    
    RMMeshBuilder* builder = [[RMMeshBuilder alloc] initWithFormat:format];
    
    for (NSArray<_RMObjMeshIndex*>* face in indexes)
    {
        if (face.count >= 3)
        {
            _RMObjMeshIndex* i = face[0];
            
            
            RMVector3* pos = i.position ? positions[[i.position integerValue]-1]:nil;
            RMVector3* norm = i.normal ? normals[[i.normal integerValue]-1]:nil;
            RMVector2* uv = i.normal ? uvs[[i.uv integerValue]-1]:nil;
            
            RMMeshVertex3D* a = [RMMeshVertex3D vertexWithPosition:pos normal:norm uv0:uv];
            
             i = face[1];
             pos = i.position ? positions[[i.position integerValue]-1]:nil;
             norm = i.normal ? normals[[i.normal integerValue]-1]:nil;
             uv = i.normal ? uvs[[i.uv integerValue]-1]:nil;

             RMMeshVertex3D* b = [RMMeshVertex3D vertexWithPosition:pos normal:norm uv0:uv];
            
            
            i = face[2];
            pos = i.position ? positions[[i.position integerValue]-1]:nil;
            norm = i.normal ? normals[[i.normal integerValue]-1]:nil;
            uv = i.normal ? uvs[[i.uv integerValue]-1]:nil;
            
            RMMeshVertex3D* c = [RMMeshVertex3D vertexWithPosition:pos normal:norm uv0:uv];
          
            if (face.count == 4)
            {
                i = face[3];
                pos = i.position ? positions[[i.position integerValue]-1]:nil;
                norm = i.normal ? normals[[i.normal integerValue]-1]:nil;
                uv = i.normal ? uvs[[i.uv integerValue]-1]:nil;
                
                RMMeshVertex3D* d = [RMMeshVertex3D vertexWithPosition:pos normal:norm uv0:uv];
                
                [builder appendQuadWithVertexA:a b:b c:c d:d];
            } else {
                [builder appendTriangleWithVertexA:a b:b c:c];
            }
            
        }
        
    }
    
    return [builder build];
}

@end
