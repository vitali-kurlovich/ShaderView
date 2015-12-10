//
//  RMProceduralMesh.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/3/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMesh.h"

#import "RMVBOVertexAttribute.h"
#import "RMProceduralMeshParam.h"

@class RMMeshBuilder;
@class RMProceduralMeshParam;

@interface RMProceduralMesh : RMMesh
@property (nonatomic, readonly) RMVBOVertexAttributeType format;

@property (nonatomic) BOOL smoothNormals;
@property (nonatomic) BOOL optimizeVBO;

- (nonnull instancetype)initWithFormat:(RMVBOVertexAttributeType)format NS_DESIGNATED_INITIALIZER;

- (void)awakeProceduralMesh; // Use for registrate mesh params

- (void)build:(nonnull RMMeshBuilder*)builder;
- (void)setNeedsRebuild;

- (nonnull NSArray<RMProceduralMeshParam*>*)params;
- (void)setParamValue:(nullable NSNumber*)value forParamName:(nonnull NSString*)name;
- (nullable RMProceduralMeshParam*)paramByName:(nonnull NSString*)name;


- (nullable RMProceduralMeshParam*)registrateMeshParamWithName:(nonnull NSString*)name
                                                          type:(RMProceduralMeshParamValueType)type
                                                         value:(nullable NSNumber*)value
                                                  defaultValue:(nullable NSNumber*)defaultValue
                                                      minValue:(nullable NSNumber*)minValue
                                                      maxValue:(nullable NSNumber*)maxValue;

- (nullable RMProceduralMeshParam*)registrateMeshParamWithName:(nonnull NSString*)name
                                                          type:(RMProceduralMeshParamValueType)type
                                                         value:(nullable NSNumber*)value;

- (nullable RMProceduralMeshParam*)registrateMeshParam:(nonnull RMProceduralMeshParam*)param;

@end

@interface RMProceduralMesh (Serialization)<NSCoding>

@end

