//
//  GetCreateAccountResourceRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/8/7.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "GetCreateAccountResourceRequest.h"

@implementation GetCreateAccountResourceRequest

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/getAccountCreateResource", REQUEST_PAY_CREATEACCOUNT_BASEURL];
}

@end
