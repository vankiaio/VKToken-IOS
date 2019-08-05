//
//  GetInvitationCodeService.h
//  VKToken
//
//  Created by vankiachain on 2019/7/31.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "InvitationCodeRequest.h"

@interface GetInvitationCodeService : BaseService

@property(nonatomic , strong) InvitationCodeRequest *invitationCodeRequest;

- (void)getInviteCode:(CompleteBlock)complete;


@end
