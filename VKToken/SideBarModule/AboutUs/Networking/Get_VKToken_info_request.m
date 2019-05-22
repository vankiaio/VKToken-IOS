//
//  Get_VKToken_info_request.m
//  VKToken
//
//  Created by vankiachain on 2018/10/31.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "Get_VKToken_info_request.h"

@implementation Get_VKToken_info_request

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/get_VKToken_info", REQUEST_PERSONAL_BASEURL];
}

@end
