//
//  RMProceduralMeshParam.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/10/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RMProceduralMeshParamValueType) {
    RMProceduralMeshParamValueTypeFloat,
    RMProceduralMeshParamValueTypeInt,
    RMProceduralMeshParamValueTypeBool
};

@interface RMProceduralMeshParam : NSObject
@property (nonnull, nonatomic, copy, readonly) NSString* name;
@property (nonatomic, readonly) RMProceduralMeshParamValueType type;

@property (nullable, nonatomic, readonly ) NSNumber* minValue;
@property (nullable, nonatomic, readonly ) NSNumber* maxValue;
@property (nullable, nonatomic, readonly ) NSNumber* defaultValue;

@property (nullable, nonatomic) NSNumber* value;

- (void)resetValue;

- (nonnull instancetype)initWithName:(nonnull NSString*)name
                                type:(RMProceduralMeshParamValueType)type
                               value:(nullable NSNumber*)value
                        defaultValue:(nullable NSNumber*)defaultValue
                            minValue:(nullable NSNumber*)minValue
                            maxValue:(nullable NSNumber*)maxValue NS_DESIGNATED_INITIALIZER;

- (nonnull instancetype)initWithName:(nonnull NSString*)name
                                type:(RMProceduralMeshParamValueType)type
                               value:(nullable NSNumber*)value;

@end


@interface RMProceduralMeshParam (Serialization)<NSCoding>
@end