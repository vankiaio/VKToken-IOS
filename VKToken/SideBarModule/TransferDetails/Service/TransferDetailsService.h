//
//  TransferDetailsService.h
//  VKToken
//
//  Created by vankiachain on 2018/8/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "TransactionRecord.h"

@interface TransferDetailsService : BaseService


@property(nonatomic , strong) NSMutableDictionary *dataSourceDictionary;

@property(nonatomic, strong) TransactionRecord *model;



@end
