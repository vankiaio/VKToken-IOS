//
//  AssestsMainService.m
//  VKToken
//
//  Created by vankiachain on 2018/1/23.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "AssestsMainService.h"
#import "AccountResult.h"
#import "Account.h"
#import "Assests.h"
#import "GetRateResult.h"
#import "Rate.h"

@interface AssestsMainService()


@end


@implementation AssestsMainService

- (GetAccountAssetRequest *)getAccountAssetRequest{
    if (!_getAccountAssetRequest) {
        _getAccountAssetRequest = [[GetAccountAssetRequest alloc] init];
    }
    return _getAccountAssetRequest;
}
- (RichListRequest *)richListRequest{
    if (!_richListRequest) {
        _richListRequest = [[RichListRequest alloc] init];
    }
    return _richListRequest;
}

- (GetRateRequest *)getRateRequest{
    if (!_getRateRequest) {
        _getRateRequest = [[GetRateRequest alloc] init];
    }
    return _getRateRequest;
}

/**
 账号资产详情
 */
- (void)get_account_asset:(CompleteBlock)complete{
    WS(weakSelf);
    
    [self.getAccountAssetRequest postDataSuccess:^(id DAO, id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            
            AccountResult *result = [AccountResult mj_objectWithKeyValues:data];
            
            if (![result.code isEqualToNumber:@0]) {
                [TOASTVIEW showWithText: VALIDATE_STRING(result.message)];
                return ;
            }
            
            Assests *vkt = [[Assests alloc] init];
            vkt.assestsName = @"VKT";
            vkt.assests_avtar = @"vkt_avatar";
            vkt.assests_balance = VALIDATE_STRING(result.data.vkt_balance);
            vkt.assests_balance_cny = VALIDATE_STRING(result.data.vkt_balance_cny);
            vkt.assests_balance_usd = VALIDATE_STRING(result.data.vkt_balance_usd);
            vkt.assests_price_change_in_24 = VALIDATE_STRING(result.data.vkt_price_change_in_24h);
            vkt.assests_market_cap_usd = VALIDATE_STRING(result.data.vkt_market_cap_usd);
            vkt.assests_market_cap_cny = VALIDATE_STRING(result.data.vkt_market_cap_cny);
            vkt.assests_price_cny = VALIDATE_STRING(result.data.vkt_price_cny);
            vkt.assests_price_usd = VALIDATE_STRING(result.data.vkt_price_usd);
            
            
            Assests *oct = [[Assests alloc] init];
            oct.assestsName = @"OCT";
            oct.assests_avtar = @"oct_avatar";
            oct.assests_balance = VALIDATE_STRING(result.data.oct_balance);
            oct.assests_balance_cny = VALIDATE_STRING(result.data.oct_balance_cny);
            oct.assests_balance_usd = VALIDATE_STRING(result.data.oct_balance_usd);
            oct.assests_price_change_in_24 = VALIDATE_STRING(result.data.oct_price_change_in_24h);
            oct.assests_market_cap_usd = VALIDATE_STRING(result.data.oct_market_cap_usd);
            oct.assests_market_cap_cny = VALIDATE_STRING(result.data.oct_market_cap_cny);
            oct.assests_price_cny = VALIDATE_STRING(result.data.oct_price_cny);
            oct.assests_price_usd = VALIDATE_STRING(result.data.oct_price_usd);
            
            weakSelf.dataSourceArray = [NSMutableArray arrayWithObjects:vkt, oct, nil];
            
            complete(result, YES);
        }
    } failure:^(id DAO, NSError *error) {
        NSLog(@"%@", error);
        complete(nil, NO);
    }];
}


/**
 get_rate
 */
- (void)get_rate:(CompleteBlock)complete{
    [self.getRateRequest postOuterDataSuccess:^(id DAO, id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            GetRateResult *result = [GetRateResult mj_objectWithKeyValues:data];
            complete(result , YES);
        }
    } failure:^(id DAO, NSError *error) {
        complete(nil , NO);
    }];
}


@end
