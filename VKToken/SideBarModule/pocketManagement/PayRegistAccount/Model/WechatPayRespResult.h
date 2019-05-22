//
//  WechatPayRespResult.h
//  VKToken
//
//  Created by vankiachain on 2018/8/7.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseResult.h"
#import "WechatPayRespModel.h"

@interface WechatPayRespResult : BaseResult
@property(nonatomic , strong) WechatPayRespModel *data;
@end
