//
//  Account.h
//  VKToken
//
//  Created by vankiachain on 2018/1/23.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 vkt账号, 
 */
@interface Account : NSObject

/**
 vkt账号名
 */
@property(nonatomic, copy) NSString *account_name;

/**
 vkt账号头像
 */
@property(nonatomic, copy) NSString *account_icon;
/**
 vkt数量
 */
@property(nonatomic, copy) NSString *vkt_balance;

/**
 vkt数量对应美元价值
 */
@property(nonatomic, copy) NSString *vkt_balance_usd;

/**
 vkt数量对应人民币价值
 */
@property(nonatomic, copy) NSString *vkt_balance_cny;

/**
 vkt价格波动
 */
@property(nonatomic, copy) NSString *vkt_price_change_in_24h;

/**
 vkt市场总值对应美元
 */
@property(nonatomic, copy) NSString *vkt_market_cap_usd;


/**
 市场总值对应人民币
 */
@property(nonatomic, copy) NSString *vkt_market_cap_cny;

/**
 美元汇率
 */
@property(nonatomic, copy) NSString *vkt_price_usd;

/**
 人民币汇率
 */
@property(nonatomic, copy) NSString *vkt_price_cny;


/**
 staked token
 */

@property(nonatomic , copy) NSString *vkt_net_weight;

@property(nonatomic , copy) NSString *vkt_cpu_weight;


//===================================//
/**
 oct数量
 */
@property(nonatomic, copy) NSString *oct_balance;

/**
 oct数量对应美元价值
 */
@property(nonatomic, copy) NSString *oct_balance_usd;

/**
 
 oct数量对应人民币价值
 */
@property(nonatomic, copy) NSString *oct_balance_cny;

/**
oct价格波动
 */
@property(nonatomic, copy) NSString *oct_price_change_in_24h;

/**
 市场总值对应美元
 */
@property(nonatomic, copy) NSString *oct_market_cap_usd;


/**
 市场总值对应人民币
 */
@property(nonatomic, copy) NSString *oct_market_cap_cny;

/**
 美元汇率
 */
@property(nonatomic, copy) NSString *oct_price_usd;

/**
 人民币汇率
 */
@property(nonatomic, copy) NSString *oct_price_cny;


@end
