//
//  PocketManagementService.h
//  VKToken
//
//  Created by vankiachain on 2018/1/31.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "BaseService.h"

@interface PocketManagementService : BaseService



/**
 数据源字典
 */
@property(nonatomic, strong) NSMutableDictionary *dataDictionary;

@property(nonatomic , copy) NSString *currentAccountName;


@end
