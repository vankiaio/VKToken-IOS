//
//  InvitationCodeRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/8/8.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "InvitationCodeRequest.h"

@implementation InvitationCodeRequest

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/VX/GenInviteCode", REQUEST_HTTP_BASEURL];
}

-(id)parameters{
    
    return @{
             @"account_id" : VALIDATE_STRING(self.account_id)
             };
}


@end
