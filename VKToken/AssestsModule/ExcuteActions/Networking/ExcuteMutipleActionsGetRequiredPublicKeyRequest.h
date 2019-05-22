//
//  ExcuteMutipleActionsGetRequiredPublicKeyRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/8/13.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseHttpsNetworkRequest.h"
#import "ExcuteActions.h"

@interface ExcuteMutipleActionsGetRequiredPublicKeyRequest : BaseHttpsNetworkRequest
@property(nonatomic, copy) NSString *ref_block_prefix;
@property(nonatomic, copy) NSString *ref_block_num;
@property(nonatomic, copy) NSString *expiration;

@property(nonatomic, copy) NSString *sender;


@property(nonatomic , strong) NSArray *excuteActionsArray;

@property(nonatomic, strong) NSArray *available_keys;

@end
