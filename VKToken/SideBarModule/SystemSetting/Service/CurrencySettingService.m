//
//  CurrencySettingService.m
//  VKToken
//
//  Created by vankiachain on 2019/6/8.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import "CurrencySettingService.h"

@implementation CurrencySettingService

- (GetCurrenciesListRequest *)getCurrenciesListRequest{
    if (!_getCurrenciesListRequest) {
        _getCurrenciesListRequest = [[GetCurrenciesListRequest alloc] init];
    }
    return _getCurrenciesListRequest;
}

- (void)buildDataSource:(CompleteBlock)complete{
    WS(weakSelf);
    [self.getCurrenciesListRequest getDataSusscess:^(id DAO, id data) {
        
        [weakSelf.dataSourceArray removeAllObjects];
        [weakSelf.responseArray removeAllObjects];
        
        BaseResult *result = [BaseResult mj_objectWithKeyValues:data];
        if (![result.code isEqualToNumber:@0]) {
            [TOASTVIEW showWithText: VALIDATE_STRING(result.message)];
            return ;
        }
        
        weakSelf.dataSourceArray = [NSMutableArray arrayWithArray:data[@"data"]];
        
        complete(@(weakSelf.dataSourceArray.count) , YES);
    } failure:^(id DAO, NSError *error) {
        complete(nil, NO);
    }];
}

- (void)buildNextPageDataSource:(CompleteBlock)complete{
    WS(weakSelf);
    [self.getCurrenciesListRequest getDataSusscess:^(id DAO, id data) {
        
        [weakSelf.dataSourceArray removeAllObjects];
        [weakSelf.responseArray removeAllObjects];
        
        BaseResult *result = [BaseResult mj_objectWithKeyValues:data];
        if (![result.code isEqualToNumber:@0]) {
            [TOASTVIEW showWithText: VALIDATE_STRING(result.message)];
            return ;
        }
        
        weakSelf.dataSourceArray = [NSMutableArray arrayWithArray:data[@"data"]];
        
        complete(@(weakSelf.dataSourceArray.count) , YES);
    } failure:^(id DAO, NSError *error) {
        complete(nil, NO);
    }];
}

@end
