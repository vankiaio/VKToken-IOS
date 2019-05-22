//
//  RedPacketResult.h
//  VKToken
//
//  Created by vankiachain on 2018/8/29.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseResult.h"
#import "RedPacket.h"

@interface RedPacketResult : BaseResult

@property(nonatomic , strong) RedPacket *data;

@end
