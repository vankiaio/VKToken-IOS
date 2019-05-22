//
//  AccountPravicyProtectionRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/3/25.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetworkRequest.h"

@interface AccountPravicyProtectionRequest : BaseNetworkRequest
/**
 需要更改隐私状态的账号名
 */
@property(nonatomic, copy) NSString *vktAccountName;

/**
 设置账号的状态 1：隐藏 0：显示
 */
@property(nonatomic, strong) NSNumber *status;

@end
