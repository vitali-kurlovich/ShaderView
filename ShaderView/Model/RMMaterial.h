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

@interface RMMaterialParam : NSObject

@property (nonnull, nonatomic, copy, readonly) NSString* title;

@end