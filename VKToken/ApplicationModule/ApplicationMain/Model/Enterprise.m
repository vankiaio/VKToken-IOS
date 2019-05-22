//
//  Enterprise.m
//  VKToken
//
//  Created by vankiachain on 2018/1/30.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "Enterprise.h"

@implementation Enterprise
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"enterprise_id" : @"id"};
}
@end
