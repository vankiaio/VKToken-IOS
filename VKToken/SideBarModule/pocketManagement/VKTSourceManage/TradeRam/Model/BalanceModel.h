//
//  BalanceModel.h
//  VKToken
//
//  Created by vankiachain on 2018/9/26.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseResult.h"

@interface BalanceModel : BaseResult
@property(nonatomic , strong) NSNumber *code;
@property(nonatomic , copy) NSString *balance;
@property(nonatomic , copy) NSString *message;
@end
