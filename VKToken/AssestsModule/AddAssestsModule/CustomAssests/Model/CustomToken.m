//
//  CustomToken.m
//  VKToken
//
//  Created by vankiachain on 2018/7/20.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "CustomToken.h"

@implementation CustomToken

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"recommandToken_ID" : @"id"
             };
}
@end
