//
//  CreateAccountResourceResult.h
//  VKToken
//
//  Created by vankiachain on 2018/8/7.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseResult.h"
#import "CreateAccountResourceRespModel.h"

@interface CreateAccountResourceResult : BaseResult
@property(nonatomic , strong) CreateAccountResourceRespModel *data;
@end
