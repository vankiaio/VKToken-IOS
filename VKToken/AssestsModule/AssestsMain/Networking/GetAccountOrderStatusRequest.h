//
//  GetAccountOrderStatusRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/8/8.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"

@interface GetAccountOrderStatusRequest : BaseNetworkRequest
@property(nonatomic , copy) NSString *accountName;
@property(nonatomic , copy) NSString *uid;
@end
