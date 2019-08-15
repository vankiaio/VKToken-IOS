//
//  AssestLockRecordsService.m
//  VKToken
//
//  Created by vankiachain on 2018/2/7.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "AssestLockRecordsService.h"
#import "AssestLockRecord.h"
#import "AssestLockRecordsResult.h"
#import "AssestLocksResult.h"
#import "VKToken-swift.h"

@interface AssestLockRecordsService()
//@property(nonatomic , assign) NSUInteger page;
//@property(nonatomic , strong) NSNumber *lastPageLastBlockNum;
@property(nonatomic , strong) AssestLockRecord *lastRecord;
@end


@implementation AssestLockRecordsService
- (GetAssestLockRecordsRequest *)getAssestLockRecordsRequest{
    if (!_getAssestLockRecordsRequest) {
        _getAssestLockRecordsRequest = [[GetAssestLockRecordsRequest alloc] init];
    }
    return _getAssestLockRecordsRequest;
}

- (void)buildDataSource:(CompleteBlock)complete{
    WS(weakSelf);
    [self.getAssestLockRecordsRequest postOuterDataSuccess:^(id DAO, id data) {
        
        [weakSelf.dataSourceArray removeAllObjects];
        [weakSelf.responseArray removeAllObjects];
      
        AssestLockRecordsResult *result = [AssestLockRecordsResult mj_objectWithKeyValues:data];
        if (![result.code isEqualToNumber:@0]) {
            [TOASTVIEW showWithText: VALIDATE_STRING(result.msg)];
        }else{
            AssestLocksResult *assestLocksResult = [AssestLocksResult mj_objectWithKeyValues:result.data];
            self.assestLocksResult = assestLocksResult;
            for (AssestLockRecord *record in assestLocksResult.lockedassets) {
                [weakSelf.responseArray addObject:record];
            }
            if (assestLocksResult.lockedassets.count>0) {
                weakSelf.lastRecord = [assestLocksResult.lockedassets lastObject];
            }
            weakSelf.dataSourceArray = [NSMutableArray arrayWithArray:weakSelf.responseArray];
        }
        complete(@(weakSelf.dataSourceArray.count) , YES);
    } failure:^(id DAO, NSError *error) {
        complete(nil, NO);
    }];
}
//
- (void)buildNextPageDataSource:(CompleteBlock)complete{
    
    WS(weakSelf);
    self.getAssestLockRecordsRequest.account_name = CURRENT_ACCOUNT_NAME;
    [self.getAssestLockRecordsRequest postOuterDataSuccess:^(id DAO, id data) {
        
        [weakSelf.dataSourceArray removeAllObjects];
        [weakSelf.responseArray removeAllObjects];
        
        AssestLockRecordsResult *result = [AssestLockRecordsResult mj_objectWithKeyValues:data];
        if (![result.code isEqualToNumber:@0]) {
            [TOASTVIEW showWithText: VALIDATE_STRING(result.msg)];
        }else{
            AssestLocksResult *assestLocksResult = [AssestLocksResult mj_objectWithKeyValues:result.data];
            for (AssestLockRecord *record in assestLocksResult.lockedassets) {
                [weakSelf.responseArray addObject:record];
            }
            if (assestLocksResult.lockedassets.count>0) {
                weakSelf.lastRecord = [assestLocksResult.lockedassets lastObject];
            }
            weakSelf.dataSourceArray = [NSMutableArray arrayWithArray:weakSelf.responseArray];
        }
        complete(@(weakSelf.dataSourceArray.count) , YES);
    } failure:^(id DAO, NSError *error) {
        complete(nil, NO);
    }];
}
@end
