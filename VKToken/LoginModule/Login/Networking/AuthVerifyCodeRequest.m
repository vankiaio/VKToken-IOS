//
//  AuthVerifyCodeRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/19.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "AuthVerifyCodeRequest.h"

@implementation AuthVerifyCodeRequest

- (NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/message/auth", REQUEST_PERSONAL_BASEURL];
}

-(id)parameters{
    return @{@"phoneNum" : VALIDATE_STRING(self.phoneNum),
             @"code" : VALIDATE_STRING(self.code)
             };
}
@end
