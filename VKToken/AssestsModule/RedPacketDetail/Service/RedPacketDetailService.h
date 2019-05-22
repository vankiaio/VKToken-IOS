//
//  RedPacketDetailService.h
//  VKToken
//
//  Created by vankiachain on 2018/7/2.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "GetRedPacketDetailRequest.h"

@interface RedPacketDetailService : BaseService
@property(nonatomic , strong) GetRedPacketDetailRequest *getRedPacketDetailRequest;

@end
