//
//  InviteCodeRegisterRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/8/8.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"

@interface InviteCodeRegisterRequest : BaseNetworkRequest

/**
 用户uid
 */
@property(nonatomic, copy) NSString *uid;

/**
 vkt账号名
 */
@property(nonatomic, copy) NSString *vktAccountName;

/**
 activeKey
 */
@property(nonatomic, copy) NSString *activeKey;

/**
 onwerKey
 */
@property(nonatomic, copy) NSString *ownerKey;

/**
 邀请码uid
 */
@property(nonatomic, copy) NSString *inviteCode;

@end
