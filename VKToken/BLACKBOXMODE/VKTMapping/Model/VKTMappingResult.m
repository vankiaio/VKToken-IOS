//
//  VKTMappingResult.m
//  VKToken
//
//  Created by vankiachain on 2018/6/13.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "VKTMappingResult.h"

@implementation VKTMappingResult
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"account_names" : @"data.account_names"};
}
@end
