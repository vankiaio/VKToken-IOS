//
//  Get_user_custom_token_request.m
//  VKToken
//
//  Created by vankiachain on 2018/7/18.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "Get_user_custom_token_request.h"

@implementation Get_user_custom_token_request

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/get_user_token?accountName=%@", REQUEST_PERSONAL_BASEURL, self.accountName];
}
@end
