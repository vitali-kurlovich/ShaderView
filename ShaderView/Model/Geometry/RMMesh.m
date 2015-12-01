//
//  RMMesh.m
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/30/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import "RMMesh.h"
#import "RMVector.h"

@implementation RMMesh
- (void)draw
{
    
}
@end



@interface RMMeshBuilder ()
@property (nonatomic, readonly) NSMutableArray< NSArray<RMVector3*>*> *position;
@property (nonatomic) NSMutableArray<RMVector3*> *currPosSequence;

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
    
    return [[RMMesh alloc] init];
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
}


- (void)appendVertex3d:(_RMVector3)vec
{
    [self appendVertex3d:vec normal:kRMVector3Zero uv0:kRMVector2Zero];
}

- (void)appendVertex3d:(_RMVector3)vec normal:(_RMVector3)normal uv0:(_RMVector2)uv0
{
    [self.currPosSequence addObject:[RMVector3 vectorWithRMVector:vec]];
}

@end
