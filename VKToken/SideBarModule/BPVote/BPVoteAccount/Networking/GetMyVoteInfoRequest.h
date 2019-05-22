//
//  GetMyVoteInfoRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/6/12.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseHttpsNetworkRequest.h"

@interface GetMyVoteInfoRequest : BaseNetworkRequest
@property(nonatomic , copy) NSString *accountNameStr;
@end
