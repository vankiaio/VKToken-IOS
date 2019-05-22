//
//  GetMyVoteInfoRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/6/12.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "GetMyVoteInfoRequest.h"

@implementation GetMyVoteInfoRequest
- (NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/votevankiachain/GetMyVoteInfo", REQUEST_BP_BASEURL];
}

-(id)parameters{
    return @{@"accountNameStr": VALIDATE_STRING(self.accountNameStr)};
}
@end
