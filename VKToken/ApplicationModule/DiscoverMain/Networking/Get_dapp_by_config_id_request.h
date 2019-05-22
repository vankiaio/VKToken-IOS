//
//  Get_dapp_by_config_id_request.h
//  VKToken
//
//  Created by vankiachain on 2018/11/1.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface Get_dapp_by_config_id_request : BaseNetworkRequest
@property(nonatomic , copy) NSString *config_id;
@end

NS_ASSUME_NONNULL_END
