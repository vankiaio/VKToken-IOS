//
//  AnswerQuestion_abi_json_to_bin_request.h
//  VKToken
//
//  Created by vankiachain on 14/05/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseHttpsNetworkRequest.h"

@interface AnswerQuestion_abi_json_to_bin_request : BaseHttpsNetworkRequest

@property(nonatomic, copy) NSString *from;

@property(nonatomic, copy) NSString *askid;

@property(nonatomic, copy) NSString *choosedanswer;


@property(nonatomic, copy) NSString *code;
@property(nonatomic, copy) NSString *action;

@end
