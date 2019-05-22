//
//  AssestLocksResult.h
//  VKToken
//
//  Created by vankiachain on 2018/2/7.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

// 交易记录 Model
@interface AssestLocksResult : NSObject

@property(nonatomic, strong) NSMutableArray *lockedassets;
/**
 合约
 */
@property(nonatomic, strong) NSString *contract;

/**
 amount
 */
@property(nonatomic , strong) NSString *amount;

/**
 amountlocked
 */
@property(nonatomic, strong) NSString *amountlocked;
/**
 availableamount
 */

@property(nonatomic, strong) NSString *availableamount;

/**
 unlockdate
 */
@property(nonatomic, strong) NSString *unlockdate;
/**
 
 token
 */
@property(nonatomic, strong) NSString *token;


/**
 decimals
 */
@property(nonatomic, strong) NSString *decimals;

@end
