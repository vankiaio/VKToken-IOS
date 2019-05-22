//
//  VipRegistAccountService.h
//  VKToken
//
//  Created by vankiachain on 2018/7/31.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "InviteCodeRegisterRequest.h"

@interface VipRegistAccountService : BaseService

@property(nonatomic , strong) InviteCodeRegisterRequest *inviteCodeRegisterRequest;

- (void)createVKTAccount:(CompleteBlock)complete;


@end
