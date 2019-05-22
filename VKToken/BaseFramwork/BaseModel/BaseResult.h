//
//  BaseResult.h
//  VKToken
//
//  Created by vankiachain on 2018/7/4.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResult : NSObject
@property(nonatomic , strong) NSNumber *code;
@property(nonatomic , copy) NSString *message;
@property(nonatomic , copy) NSString *msg;

@end
