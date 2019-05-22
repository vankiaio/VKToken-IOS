//
//  GetAccountNameByWifRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/6/13.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "GetAccountNameByWifRequest.h"

@implementation GetAccountNameByWifRequest

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/votevankiachain/GetAccounts", REQUEST_BP_BASEURL];
}

-(id)parameters{
    return @{@"public_key": VALIDATE_STRING(self.public_key)};
}

@end
