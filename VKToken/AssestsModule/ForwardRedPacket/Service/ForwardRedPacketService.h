//
//  ForwardRedPacketService.h
//  VKToken
//
//  Created by vankiachain on 2018/7/2.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "Auth_redpacket_request.h"

@interface ForwardRedPacketService : BaseService
@property(nonatomic , strong) Auth_redpacket_request *auth_redpacket_request;



- (void)authRedpacket:(CompleteBlock)complete;
@end
