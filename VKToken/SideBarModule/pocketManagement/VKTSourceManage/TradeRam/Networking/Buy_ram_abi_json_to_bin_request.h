//
//  Buy_ram_abi_json_to_bin_request.h
//  VKToken
//
//  Created by vankiachain on 2018/6/22.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseHttpsNetworkRequest.h"

@interface Buy_ram_abi_json_to_bin_request : BaseHttpsNetworkRequest
@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *action;
@property(nonatomic, copy) NSString *payer;
@property(nonatomic, copy) NSString *receiver;
@property(nonatomic, copy) NSString *quant;


@end
