//
//  UserInfoResult.h
//  VKToken
//
//  Created by vankiachain on 2018/7/5.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseResult.h"
#import "UserInfo.h"

@interface UserInfoResult : BaseResult
@property(nonatomic , strong) UserInfo *data;
@end
