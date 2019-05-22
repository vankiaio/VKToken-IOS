//
//  TransactionsResult.m
//  VKToken
//
//  Created by vankiachain on 2018/2/7.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "TransactionsResult.h"

@implementation TransactionsResult
+(NSDictionary *)mj_objectClassInArray{
    return @{ @"actions" : @"TransactionRecord"};
}
@end
