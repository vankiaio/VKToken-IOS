//
//  UnbindWechatRequest.m
//  VKToken
//
//  Created by vankiachain on 30/03/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "UnbindWechatRequest.h"

@implementation UnbindWechatRequest
-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/user/unbindWechat", REQUEST_PERSONAL_BASEURL];
}

-(id)parameters{
    return @{@"uid" : VALIDATE_STRING(self.uid)
             };
}
@end
