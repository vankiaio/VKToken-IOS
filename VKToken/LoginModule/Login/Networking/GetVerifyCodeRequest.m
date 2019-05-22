//
//  GetVerifyCodeRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/19.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "GetVerifyCodeRequest.h"

@implementation GetVerifyCodeRequest
- (NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/message_push/send_message", REQUEST_MESSAGE_PUSH_BASEURL];
}

-(id)parameters{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:VALIDATE_STRING( self.phoneNum) forKey:@"phoneNum"];
    [params setObject:VALIDATE_STRING( self.type) forKey:@"type"];
    return [params clearEmptyObject];
}
@end
