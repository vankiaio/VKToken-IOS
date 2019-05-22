//
//  GetRamHourChangerageRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/10/29.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "GetRamHourChangerageRequest.h"

@implementation GetRamHourChangerageRequest
-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/vktDataConditionSearchRam/GetHourChangerage", REQUEST_HISTORY_HTTP];
}

@end
