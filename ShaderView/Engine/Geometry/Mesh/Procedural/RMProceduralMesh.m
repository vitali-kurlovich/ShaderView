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

#import "RMProceduralMeshParam.h"

@protocol _RMProceduralMeshParamDelegate <NSObject>
- (void)proceduralMeshParamValueDidChange:(RMProceduralMeshParam*)param;
@end

@interface _RMProceduralMeshParam : RMProceduralMeshParam
@property (nonatomic, weak) id<_RMProceduralMeshParamDelegate> delegate;
@end


@interface RMProceduralMesh()<_RMProceduralMeshParamDelegate>
@property (nonatomic, readonly) RMMesh* mesh;
@property (nonatomic, readonly) RMMeshBuilder* meshBuilder;
@property (nonatomic, readonly) NSMutableArray<RMProceduralMeshParam*>* mutableParams;
@end

@implementation RMProceduralMesh
@synthesize mesh = _mesh;
@synthesize meshBuilder = _meshBuilder;
@synthesize mutableParams = _mutableParams;
- (instancetype)init
{
    return [self initWithFormat:(RMVBOVertexAttributeTypePosition | RMVBOVertexAttributeTypeNormal | RMVBOVertexAttributeTypeUV0)];
}

- (nonnull instancetype)initWithFormat:(RMVBOVertexAttributeType)format
{
    self = [super init];
    if (self)
    {
        _format = format;
        _optimizeVBO = YES;
    }
    return self;
}


- (NSMutableArray<RMProceduralMeshParam*>* )mutableParams
{
    if (_mutableParams == nil)
    {
        _mutableParams = [NSMutableArray array];
        
        [self awakeProceduralMesh];
    }
    return _mutableParams;
}

- (void)awakeProceduralMesh
{
    
}

- (nullable RMProceduralMeshParam*)registrateMeshParamWithName:(NSString*)name
                                                          type:(RMProceduralMeshParamValueType)type
                                                         value:(nullable NSNumber*)value
{
    return [self registrateMeshParamWithName:name type:type value:value defaultValue:nil minValue:nil maxValue:nil];
}


- (nullable RMProceduralMeshParam*)registrateMeshParam:(RMProceduralMeshParam*)param
{
    return [self registrateMeshParamWithName:param.name
                                        type:param.type
                                       value:param.value
                                defaultValue:param.defaultValue
                                    minValue:param.minValue maxValue:param.maxValue];
}

- (nullable RMProceduralMeshParam*)registrateMeshParamWithName:(NSString*)name
                                                   type:(RMProceduralMeshParamValueType)type
                                                  value:(nullable NSNumber*)value
                                           defaultValue:(nullable NSNumber*)defaultValue
                                               minValue:(nullable NSNumber*)minValue
                                               maxValue:(nullable NSNumber*)maxValue
{
    if (name.length == 0) return nil;
    
    _RMProceduralMeshParam* param = [[_RMProceduralMeshParam alloc] initWithName:name
                                                                            type:type
                                                                           value:value
                                                                    defaultValue:defaultValue
                                                                        minValue:minValue
                                                                        maxValue:maxValue];
    param.delegate = self;
    
    __block NSInteger index = NSNotFound;
    [self.mutableParams enumerateObjectsUsingBlock:^(RMProceduralMeshParam * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqual:name])
        {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index != NSNotFound)
    {
        self.mutableParams[index] = param;
    } else {
        [self.mutableParams addObject:param];
    }
    
     [self setNeedsRebuild];
    
    return param;
}


- (nonnull NSArray<RMProceduralMeshParam*>*)params
{
    return [self.mutableParams copy];
}

- (void)setParamValue:(nullable NSNumber*)value forParamName:(nonnull NSString*)name
{
    [self paramByName:name].value = value;
}

- (nullable RMProceduralMeshParam*)paramByName:(nonnull NSString*)name
{
    __block RMProceduralMeshParam* param = nil;
    [self.mutableParams enumerateObjectsUsingBlock:^(RMProceduralMeshParam * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.name isEqual:name])
        {
            param = obj;
            *stop = YES;
        }
    }];
    
    return param;
}


- (void)setSmoothNormals:(BOOL)smoothNormals
{
    if (_smoothNormals != smoothNormals)
    {
        _smoothNormals = smoothNormals;
        [self setNeedsRebuild];
    }
}

- (RMVBOObject*)vbo
{
    return self.mesh.vbo;
}

- (void)setOptimizeVBO:(BOOL)optimizeVBO
{
    if (_optimizeVBO != optimizeVBO)
    {
        _optimizeVBO = optimizeVBO;
        if (optimizeVBO)
        {
            [self setNeedsRebuild];
        }
    }
}


- (RMMesh*)mesh
{
    if (_mesh == nil)
    {
        RMMeshBuilder* builder = [[RMMeshBuilder alloc] initWithFormat:self.format];
        
        builder.useOptimization = self.optimizeVBO;
        
        [self build:builder];
        _mesh = [builder build];
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

#pragma mark - _RMProceduralMeshParamDelegate
- (void)proceduralMeshParamValueDidChange:(RMProceduralMeshParam*)param
{
    [self setNeedsRebuild];
}

@end


@implementation _RMProceduralMeshParam

- (void)setValue:(NSNumber *)value
{
    NSNumber* oldValue = self.value;
    
    super.value = value;
    
    if (oldValue != self.value && ![self.value isEqual:oldValue])
    {
        [self.delegate proceduralMeshParamValueDidChange:self];
    }
}

@end
