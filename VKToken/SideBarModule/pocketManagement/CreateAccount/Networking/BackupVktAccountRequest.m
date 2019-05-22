//
//  BackupVktAccountRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/23.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "BackupVktAccountRequest.h"

@implementation BackupVktAccountRequest
-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/user/add_new_vkt", REQUEST_PERSONAL_BASEURL];
}

-(id)parameters{
    return @{
             @"uid" : VALIDATE_STRING(self.uid),
             @"vktAccountName" : VALIDATE_STRING(self.vktAccountName)
             
             };
}
@end
