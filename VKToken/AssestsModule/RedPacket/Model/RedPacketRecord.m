//
//  RedPacketRecord.m
//  VKToken
//
//  Created by vankiachain on 20/04/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "RedPacketRecord.h"

@implementation RedPacketRecord
+(NSDictionary *)mj_replacedKeyFromPropertyName{
     return @{@"redPacket_id" : @"id" };
}
@end
