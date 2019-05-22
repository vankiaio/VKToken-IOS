//
//  RamRateChange.m
//  VKToken
//
//  Created by vankiachain on 2018/10/29.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "RamRateChange.h"

@implementation RamRateChange

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{ @"rateChange" : @"data.rateChange"};
}

@end
