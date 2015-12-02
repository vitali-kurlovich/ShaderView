//
//  RMMeshBuilder.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 12/2/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMeshBuilder.h"

#import "RMVector.h"

@interface RMMeshBuilder ()
@property (nonatomic, readonly) NSMutableArray< NSArray<RMVector3*>*> *position;
@property (nonatomic) NSMutableArray<RMVector3*> *currPosSequence;


@property (nonatomic, readonly) NSMutableArray< NSArray<RMVector3*>*> *normal;
@property (nonatomic) NSMutableArray<RMVector3*> *currNormalSequence;

@property (nonatomic, readonly) NSMutableArray< NSArray<RMVector2*>*> *uv0;
@property (nonatomic) NSMutableArray<RMVector2*> *currUV0Sequence;



@property (nonatomic) BOOL needsUpdate;


@end

@implementation RMMeshBuilder


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _position = [NSMutableArray array];
        _currPosSequence = [NSMutableArray array];
        
        _normal = [NSMutableArray array];
        _currNormalSequence = [NSMutableArray array];
        
        _uv0 = [NSMutableArray array];
        _currUV0Sequence = [NSMutableArray array];
    }
    return self;
}

- (nonnull RMMesh*)build
{
    if (self.currPosSequence.count > 2)
    {
        [self.position addObject:[self.currPosSequence copy]];
        self.currPosSequence = [NSMutableArray array];
    }
    
    
    if (self.currNormalSequence.count > 2)
    {
        [self.normal addObject:[self.currNormalSequence copy]];
        self.currNormalSequence = [NSMutableArray array];
    }
    
    if (self.currUV0Sequence.count > 2)
    {
        [self.uv0 addObject:[self.currUV0Sequence copy]];
        self.currUV0Sequence = [NSMutableArray array];
    }
    
    
    NSInteger globalPointsCount = 0;
    for (NSArray* arr in self.position)
    {
        globalPointsCount += arr.count;
    }
    
    
    
    
    
    
    
    return nil;
}

- (void)insertVertex3d:(_RMVector3)vec
{
    [self insertVertex3d:vec normal:kRMVector3Zero uv0:kRMVector2Zero];
}

- (void)insertVertex3d:(_RMVector3)vec normal:(_RMVector3)normal uv0:(_RMVector2)uv0
{
    if (self.currPosSequence.count > 2)
    {
        [self.position addObject:[self.currPosSequence copy]];
    }
    self.currPosSequence = [@[[RMVector3 vectorWithRMVector:vec]] mutableCopy];
    
    if (self.currNormalSequence.count > 2)
    {
        [self.normal addObject:[self.currNormalSequence copy]];
    }
    self.currNormalSequence = [@[[RMVector3 vectorWithRMVector:normal]] mutableCopy];
    
    if (self.currUV0Sequence.count > 2)
    {
        [self.uv0 addObject:[self.currUV0Sequence copy]];
    }
    self.currUV0Sequence = [@[[RMVector2 vectorWithRMVector:uv0]] mutableCopy];
}


- (void)appendVertex3d:(_RMVector3)vec
{
    [self appendVertex3d:vec normal:kRMVector3Zero uv0:kRMVector2Zero];
}

- (void)appendVertex3d:(_RMVector3)vec normal:(_RMVector3)normal uv0:(_RMVector2)uv0
{
    [self.currPosSequence addObject:[RMVector3 vectorWithRMVector:vec]];
    [self.currNormalSequence addObject:[RMVector3 vectorWithRMVector:normal]];
    [self.currUV0Sequence addObject:[RMVector2 vectorWithRMVector:uv0]];
}

@end
