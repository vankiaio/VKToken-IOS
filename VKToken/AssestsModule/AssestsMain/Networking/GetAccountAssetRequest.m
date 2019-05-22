//
//  GetAccountAssetRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/23.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "GetAccountAssetRequest.h"

@implementation GetAccountAssetRequest

-(NSString *)requestUrlPath{
    return @"/get_account_asset";
}

-(id)parameters{
    return @{@"name" : VALIDATE_STRING(self.name) };
}
@end
