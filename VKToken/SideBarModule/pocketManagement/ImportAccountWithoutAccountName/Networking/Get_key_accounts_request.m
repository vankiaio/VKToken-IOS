//
//  Get_key_accounts_request.m
//  VKToken
//
//  Created by vankiachain on 2018/11/16.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "Get_key_accounts_request.h"

@implementation Get_key_accounts_request

- (NSString *)requestUrlPath{
    return @"/get_key_accounts";
}

- (id)parameters{
    return @{@"public_key" : VALIDATE_STRING(self.public_key)};
}
@end
