//
//  RMProceduralMeshParam.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/10/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMProceduralMeshParam.h"

@implementation RMProceduralMeshParam

- (instancetype)init
{
    return [self initWithName:@"none" type:RMProceduralMeshParamValueTypeFloat value:nil];
}

- (nonnull instancetype)initWithName:(nonnull NSString*)name
                                type:(RMProceduralMeshParamValueType)type
                               value:(nullable NSNumber*)value
{
    return [self initWithName:name type:type value:value defaultValue:nil minValue:nil maxValue:nil];
}

- (nonnull instancetype)initWithName:(nonnull NSString*)name
                                type:(RMProceduralMeshParamValueType)type
                               value:(nullable NSNumber*)value
                        defaultValue:(nullable NSNumber*)defaultValue
                            minValue:(nullable NSNumber*)minValue
                            maxValue:(nullable NSNumber*)maxValue
{
    self = [super init];
    if (self)
    {
        _name = [name copy];
        _type = type;
        
        _defaultValue = defaultValue;
        _minValue = minValue;
        _maxValue = maxValue;
        
        
        NSNumber* val = (value == nil ? @(0) : value) ;
        
        if (_minValue)
        {
            if ([val compare:_minValue] == NSOrderedAscending)
            {
                val = _minValue;
            }
        }
        
        if (_maxValue)
        {
            if ([val compare:_maxValue] == NSOrderedDescending)
            {
                val = _maxValue;
            }
        }
        
        _value = val;
    }
    return self;
}

- (void)resetValue
{
    self.value = self.defaultValue;
}

- (void)setValue:(NSNumber *)value
{
    NSNumber* val = (value == nil ? @(0) : value) ;
    
    if (self.minValue)
    {
        if ([val compare:self.minValue] == NSOrderedAscending)
        {
            val = self.minValue;
        }
    }
    
    if (self.maxValue)
    {
        if ([val compare:self.maxValue] == NSOrderedDescending)
        {
            val = self.maxValue;
        }
    }
    
    if (_value != val && ![_value isEqual:val])
    {
        _value = val;
        
    }
}
@end

static NSString * const kNameKey = @"name";
static NSString * const kTypeKey = @"type";
static NSString * const kValueKey = @"value";
static NSString * const kDefaultValueKey = @"dvalue";
static NSString * const kMinValueKey = @"minvalue";
static NSString * const kMaxValueKey = @"maxvalue";

@implementation RMProceduralMeshParam (Serialization)

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:kNameKey];
    [aCoder encodeInteger:self.type forKey:kTypeKey];
    
    [aCoder encodeObject:self.value forKey:kValueKey];
    
    [aCoder encodeObject:self.defaultValue forKey:kDefaultValueKey];
    [aCoder encodeObject:self.minValue forKey:kMinValueKey];
    [aCoder encodeObject:self.maxValue forKey:kMaxValueKey];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    NSString* name = [aDecoder decodeObjectForKey:kNameKey];
    RMProceduralMeshParamValueType type = [aDecoder decodeIntegerForKey:kTypeKey];
    NSNumber* value = [aDecoder decodeObjectForKey:kValueKey];
    
     NSNumber* defaultValue = [aDecoder decodeObjectForKey:kDefaultValueKey];
    
    NSNumber* minValue = [aDecoder decodeObjectForKey:kMinValueKey];
    NSNumber* maxValue = [aDecoder decodeObjectForKey:kMaxValueKey];
    
    return [self initWithName:name type:type value:value defaultValue:defaultValue minValue:minValue maxValue:maxValue];
}

@end
