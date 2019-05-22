//
//  Get_table_rows_request.m
//  VKToken
//
//  Created by vankiachain on 2018/6/22.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "Get_table_rows_request.h"

@implementation Get_table_rows_request

-(NSString *)requestUrlPath{
    return @"/get_table_rows";
}

-(id)parameters{
    return @{@"json":[NSNumber numberWithBool:YES],@"code":VALIDATE_STRING(self.code),@"scope":VALIDATE_STRING(self.scope),@"table":VALIDATE_STRING(self.table),@"table_key":@"",@"lower_bound":@"",@"upper_bound":@"",@"limit":@10};
}

@end
