//
//  GetRateRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/3/22.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "GetRateRequest.h"

@implementation GetRateRequest
-(NSString *)requestUrlPath{
    return @"/get_rate";
}

-(id)parameters{
    return @{@"coinmarket_id" : VALIDATE_STRING(self.coinmarket_id) };
}

@end
