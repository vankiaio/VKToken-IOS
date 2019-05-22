//
//  CreateVKTAccountRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/6/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "CreateVKTAccountRequest.h"

@implementation CreateVKTAccountRequest
-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/user/add_new_vkt", REQUEST_PERSONAL_BASEURL];
}

-(id)parameters{
    
    return @{
             @"uid" : VALIDATE_STRING(self.uid),
             @"vktAccountName" : VALIDATE_STRING(self.vktAccountName),
             @"activeKey" : VALIDATE_STRING(self.activeKey),
             @"ownerKey" : VALIDATE_STRING(self.ownerKey)
             
             };
}
@end
