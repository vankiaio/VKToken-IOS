//
//  Get_account_assetsRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/10/20.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseHttpsNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN


/**
 （新版本，支持新上币）
 */
@interface Get_account_assetsRequest : BaseHttpsNetworkRequest
/**
 
 */
@property(nonatomic , strong) NSArray *accountInfoArr;


@end

NS_ASSUME_NONNULL_END
