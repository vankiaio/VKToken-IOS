//
//  SetMainAccountRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/31.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "SetMainAccountRequest.h"

@implementation SetMainAccountRequest
-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/user/toggleVktMain", REQUEST_PERSONAL_BASEURL];;
}
-(id)parameters{
    return @{@"uid" : VALIDATE_STRING(self.uid),
             @"vktAccountName" : VALIDATE_STRING(self.vktAccountName)};
}
@end
