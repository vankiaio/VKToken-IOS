//
//  VKTResourceService.h
//  VKToken
//
//  Created by vankiachain on 2018/6/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "GetAccountRequest.h"
#import "VKTResourceResult.h"
#import "VKTResource.h"
#import "VKTResourceCellModel.h"


@interface VKTResourceService : BaseService
@property(nonatomic, strong) GetAccountRequest *getAccountRequest;

@property(nonatomic , strong) VKTResourceResult *vktResourceResult;
/**
 账号资产详情
 */
- (void)get_account:(CompleteBlock)complete;



@end
