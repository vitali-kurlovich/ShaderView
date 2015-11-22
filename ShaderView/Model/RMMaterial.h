//
//  RMMaterial.h
//  ShaderView
//
//  Created by Vitali Kurlovich on 11/22/15.
//  Copyright © 2015 Vitali Kurlovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RMProgram;

@interface RMMaterial : NSObject

@property (nullable, nonatomic) RMProgram* shader;


@end
