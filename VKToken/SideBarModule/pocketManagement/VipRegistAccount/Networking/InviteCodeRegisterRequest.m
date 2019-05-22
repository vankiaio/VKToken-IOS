//
//  InviteCodeRegisterRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/8/8.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "InviteCodeRegisterRequest.h"

@implementation InviteCodeRegisterRequest

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/inviteCodeRegister", REQUEST_PERSONAL_BASEURL];
}

-(id)parameters{
    
    return @{
             @"inviteCode" : VALIDATE_STRING(self.inviteCode),
             @"uid" : VALIDATE_STRING(self.uid),
             @"vktAccountName" : VALIDATE_STRING(self.vktAccountName),
             @"activeKey" : VALIDATE_STRING(self.activeKey),
             @"ownerKey" : VALIDATE_STRING(self.ownerKey)
             
             };
}


@end
