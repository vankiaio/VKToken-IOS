//
//  Candy_task_list_request.m
//  VKToken
//
//  Created by vankiachain on 2018/5/24.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "Candy_task_list_request.h"

@implementation Candy_task_list_request


-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/get_user_task/%@", REQUEST_CANDYSYSTEM_BASEURL, self.uid];
    
}

@end
