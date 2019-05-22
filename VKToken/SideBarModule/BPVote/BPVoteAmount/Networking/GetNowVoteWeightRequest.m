//
//  GetNowVoteWeightRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/6/12.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "GetNowVoteWeightRequest.h"

@implementation GetNowVoteWeightRequest
- (NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/votevankiachain/GetNowVoteWeight", REQUEST_BP_BASEURL];
}


@end
