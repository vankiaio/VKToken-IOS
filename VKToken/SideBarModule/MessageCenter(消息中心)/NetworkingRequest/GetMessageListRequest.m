//
//  GetMessageListRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/29.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "GetMessageListRequest.h"

@implementation GetMessageListRequest
-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/message/mobileList", REQUEST_MESSAGE_BASEURL];
}
-(id)parameters{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:VALIDATE_NUMBER(self.offset) forKey:@"pageNo"];
    [params setObject:VALIDATE_NUMBER(self.size) forKey:@"pageSize"];
    [params setObject:VALIDATE_STRING(self.userID) forKey:@"mobileUserId"];
    return [params clearEmptyObject];
}
@end
