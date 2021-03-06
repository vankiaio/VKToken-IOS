//
//  Get_key_accounts_request.h
//  VKToken
//
//  Created by vankiachain on 2018/11/16.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseHttpsNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface Get_key_accounts_request : BaseHttpsNetworkRequest
/**
 账号名
 */
@property(nonatomic, copy) NSString *public_key;
@end

NS_ASSUME_NONNULL_END
