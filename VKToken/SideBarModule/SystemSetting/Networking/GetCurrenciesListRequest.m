//
//  GetCurrenciesListRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/29.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "GetCurrenciesListRequest.h"

@implementation GetCurrenciesListRequest

-(NSString *)requestUrlPath{
     return [NSString stringWithFormat:@"%@/vktapi/v1/getcurrencies", REQUEST_HTTP_BASEURL];
}

//-(id)parameters{
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    return [params clearEmptyObject];
//}


@end
