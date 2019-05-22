//
//  BackupVktAccountRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/1/23.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"


/**
 给用户添加新的vkt账号
 */
@interface BackupVktAccountRequest : BaseNetworkRequest

/**
 用户uid
 */
@property(nonatomic, copy) NSString *uid;

/**
 vkt账号名
 */
@property(nonatomic, copy) NSString *vktAccountName;


@end
