//
//  Buy_ram_abi_json_to_bin_request.m
//  VKToken
//
//  Created by vankiachain on 2018/6/22.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "Buy_ram_abi_json_to_bin_request.h"

@implementation Buy_ram_abi_json_to_bin_request
-(NSString *)requestUrlPath{
    return @"/abi_json_to_bin";
}

-(NSDictionary *)parameters{
    // 交易JSON序列化
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject: VALIDATE_STRING(self.code) forKey:@"code"];
    [params setObject:VALIDATE_STRING(self.action) forKey:@"action"];
    NSMutableDictionary *args = [NSMutableDictionary dictionary];
    [args setObject:VALIDATE_STRING(self.payer) forKey:@"payer"];
    [args setObject:VALIDATE_STRING(self.receiver) forKey:@"receiver"];
    [args setObject:VALIDATE_STRING(self.quant) forKey:@"quant"];
    [params setObject:args forKey:@"args"];
    return params;
}
@end
