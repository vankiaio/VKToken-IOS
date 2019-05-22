//
//  ImportAccountsRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/8/22.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "ImportAccountsRequest.h"

@implementation ImportAccountsRequest
-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/import_accounts", REQUEST_PERSONAL_BASEURL];
}

-(NSDictionary *)parameters{
    NSDictionary *params = @{
                             @"uid" : VALIDATE_STRING(CURRENT_WALLET_UID),
                             @"accountList" : VALIDATE_ARRAY(self.accountList)
                             };
    return params;
}

@end
