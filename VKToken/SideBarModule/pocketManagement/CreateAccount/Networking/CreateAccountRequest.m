//
//  CreateAccountRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/19.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "CreateAccountRequest.h"

@implementation CreateAccountRequest


-(NSString *)requestUrlPath{
    return @"/create_account";
}

-(id)parameters{
    return @{
             @"account_name" : VALIDATE_STRING(self.account_name),
             @"owner_key" : VALIDATE_STRING(self.owner_key),
             @"active_key" : VALIDATE_STRING(self.active_key)
             
             };
}
@end
