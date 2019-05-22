//
//  AccountPravicyProtectionRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/3/25.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "AccountPravicyProtectionRequest.h"

@implementation AccountPravicyProtectionRequest

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/user/update_secret", REQUEST_PERSONAL_BASEURL];
}

-(NSDictionary *)parameters{
    NSDictionary *params = @{
                             @"vktAccountName" : VALIDATE_STRING(self.vktAccountName),
                             @"status" : VALIDATE_STRING(self.status)
                             
                             };
    return params;
}


@end
