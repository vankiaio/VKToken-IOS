//
//  UnbindWechatRequest.h
//  VKToken
//
//  Created by vankiachain on 30/03/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"

@interface UnbindWechatRequest : BaseNetworkRequest
/**
 用户uid
 */
@property(nonatomic , copy) NSString *uid;
@end
