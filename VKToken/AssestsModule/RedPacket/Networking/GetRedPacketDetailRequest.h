//
//  GetRedPacketDetailRequest.h
//  VKToken
//
//  Created by vankiachain on 20/04/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"


/**
 get redpacket detail
 */
@interface GetRedPacketDetailRequest : BaseNetworkRequest
/**
 
 */
@property(nonatomic, copy) NSString *redPacket_id;

@end
