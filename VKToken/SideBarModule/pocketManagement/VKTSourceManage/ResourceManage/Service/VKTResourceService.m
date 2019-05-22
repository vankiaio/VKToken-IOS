//
//  VKTResourceService.m
//  VKToken
//
//  Created by vankiachain on 2018/6/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "VKTResourceService.h"


@implementation VKTResourceService

- (GetAccountRequest *)getAccountRequest{
    if (!_getAccountRequest) {
        _getAccountRequest = [[GetAccountRequest alloc] init];
    }
    return _getAccountRequest;
}
//
//- (VKTResourceResult *)vktResourceResult{
//    if (!_vktResourceResult) {
//        _vktResourceResult = [[VKTResourceResult alloc] init];
//    }
//    return _vktResourceResult;
//}


/**
 账号资产详情
 */
- (void)get_account:(CompleteBlock)complete{
    WS(weakSelf);
    
    [self.getAccountRequest postDataSuccess:^(id DAO, id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            
            weakSelf.vktResourceResult = [VKTResourceResult mj_objectWithKeyValues:data];
            
            if (![weakSelf.vktResourceResult.code isEqualToNumber:@0]) {
                [TOASTVIEW showWithText: VALIDATE_STRING(weakSelf.vktResourceResult.message)];
                return ;
            }
            
            VKTResourceCellModel *cpu_model = [[VKTResourceCellModel alloc] init];
            cpu_model.title = NSLocalizedString(@"cpu", nil);
            cpu_model.used = weakSelf.vktResourceResult.data.cpu_used;
            cpu_model.available = weakSelf.vktResourceResult.data.cpu_available;
            cpu_model.max = weakSelf.vktResourceResult.data.cpu_max;
            cpu_model.weight = weakSelf.vktResourceResult.data.cpu_weight;
            
            VKTResourceCellModel *net_model = [[VKTResourceCellModel alloc] init];
            net_model.title = NSLocalizedString(@"net", nil);
            net_model.used = weakSelf.vktResourceResult.data.net_used;
            net_model.available = weakSelf.vktResourceResult.data.net_available;
            net_model.max = weakSelf.vktResourceResult.data.net_max;
            net_model.weight = weakSelf.vktResourceResult.data.net_weight;
            
            weakSelf.dataSourceArray = [NSMutableArray arrayWithObjects:cpu_model, net_model, nil];
            complete(weakSelf.vktResourceResult, YES);
        }
    } failure:^(id DAO, NSError *error) {
        NSLog(@"%@", error);
        complete(nil, NO);
    }];
}


@end
