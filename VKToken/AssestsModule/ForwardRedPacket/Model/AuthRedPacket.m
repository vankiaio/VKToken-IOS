//
//  AuthRedPacket.m
//  VKToken
//
//  Created by vankiachain on 2018/7/2.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "AuthRedPacket.h"

@implementation AuthRedPacket

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"redpacket_id" : @"id"
             
             };
}

@end
