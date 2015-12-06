//
//  RMMaterial.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMProgram;
@class RMMaterialParam;

@interface RMMaterial : NSObject

@property (nonnull, nonatomic, readonly) RMProgram* shader;
@property (nonnull, nonatomic, readonly) NSArray<RMMaterialParam*>* params;


@end


typedef NS_ENUM(NSInteger, RMMaterialParamValueType) {
    RMMaterialParamTypeValueFloat,
    RMMaterialParamTypeValueInt,
    RMMaterialParamTypeValueColor,
    RMMaterialParamTypeTexture,
};

@interface RMMaterialParamValue : NSObject
@property (nonatomic, readonly) RMMaterialParamValueType type;
@end

@interface RMMaterialParamRange : NSObject

@property (nonnull, readonly) RMMaterialParamValue* defaultValue;
@property (nonnull, readonly) RMMaterialParamValue* minValue;
@property (nonnull, readonly) RMMaterialParamValue* maxValue;

@end

@interface RMMaterialParam : NSObject

@property (nonnull, nonatomic, copy, readonly) NSString* name;

@end