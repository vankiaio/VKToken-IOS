//
//  Validata_Invitecode.m
//  VKToken
//
//  Created by 李轶 on 2019/11/27.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import "Validata_Invitecode_Request.h"

@implementation Validata_Invitecode_Request

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/user/validata_invitecode", REQUEST_PERSONAL_BASEURL ];
}

-(id)parameters{
    return @{@"InvitationCode" : VALIDATE_STRING(self.InvitationCode) };
}
@end

