//
//  CreateAccountResourceRespModel.h
//  VKToken
//
//  Created by vankiachain on 2018/8/7.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateAccountResourceRespModel : NSObject

@property(nonatomic , strong) NSNumber *cnyCost;
@property(nonatomic , copy) NSString *ram;
@property(nonatomic , copy) NSString *net;
@property(nonatomic , copy) NSString *cpu;

@end
