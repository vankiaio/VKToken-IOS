//
//  BalanceModel.m
//  VKToken
//
//  Created by vankiachain on 2018/9/26.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BalanceModel.h"

@implementation BalanceModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"balance" : @"data.rows[0].balance",
             };
}
@end
