//
//  MessageCenterResult.m
//  VKToken
//
//  Created by vankiachain on 2018/1/29.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "MessageCenterResult.h"

@implementation MessageCenterResult

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"data" : @"result.records"
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"data" : @"MessageCenter"
             };
}
@end
