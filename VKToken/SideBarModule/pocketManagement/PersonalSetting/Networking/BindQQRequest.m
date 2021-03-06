//
//  BindQQRequest.m
//  VKToken
//
//  Created by vankiachain on 30/03/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BindQQRequest.h"

@implementation BindQQRequest
-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/user/bindqq", REQUEST_PERSONAL_BASEURL];
}

-(id)parameters{
    return @{@"uid" : VALIDATE_STRING(self.uid),
             @"name" : VALIDATE_STRING(self.name),
             @"avatar" : VALIDATE_STRING(self.avatar),
             @"openid" : VALIDATE_STRING(self.openid),
             };
}
@end
