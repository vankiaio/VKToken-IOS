//
//  AssestLockRecordsService.h
//  VKToken
//
//  Created by vankiachain on 2018/2/7.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "GetAssestLockRecordsRequest.h"
#import "AssestLocksResult.h"

@interface AssestLockRecordsService : BaseService
@property(nonatomic, strong) AssestLocksResult *assestLocksResult;
@property(nonatomic, strong) GetAssestLockRecordsRequest *getAssestLockRecordsRequest;
- (void)buildNextPageDataSource:(CompleteBlock)complete;
@end
