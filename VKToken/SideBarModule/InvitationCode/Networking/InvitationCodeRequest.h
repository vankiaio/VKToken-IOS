//
//  InviteCodeRegisterRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/8/8.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"

@interface InvitationCodeRequest : BaseNetworkRequest
/**
 用户account_id
 */
@property(nonatomic, copy) NSString *account_id;


@end
