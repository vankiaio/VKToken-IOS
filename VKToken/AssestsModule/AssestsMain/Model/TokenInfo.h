//
//  TokenInfo.h
//  VKToken
//
//  Created by vankiachain on 2018/7/19.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenInfo : OptionModel<NSCoding>

/**
 contract_name
 */
@property(nonatomic, copy) NSString *contract_name;

/**
 token_symbol
 */
@property(nonatomic, copy) NSString *token_symbol;
/**
 coinmarket_id
 */
@property(nonatomic, copy) NSString *coinmarket_id;

/**
 account_name
 */
@property(nonatomic, copy) NSString *account_name;

/**
 balance
 */
@property(nonatomic, copy) NSString *balance;

/**
 balance
 */
@property(nonatomic, copy) NSString *locked_amount;

/**
 balance_usd
 */
@property(nonatomic, copy) NSString *balance_usd;
/**
 balance_cny
 */
@property(nonatomic, copy) NSString *balance_cny;
/**
 balance_krw
 */
@property(nonatomic, copy) NSString *balance_krw;

/**
 asset_price_usd
 */
@property(nonatomic, copy) NSString *asset_price_usd;

/**
 asset_price_cny
 */
@property(nonatomic, copy) NSString *asset_price_cny;

/**
 asset_price_krw
 */
@property(nonatomic, copy) NSString *asset_price_krw;

/**
 asset_price_change_in_24h
 */
@property(nonatomic, copy) NSString *asset_price_change_in_24h;
/**
 iconUrl
 */
@property(nonatomic, copy) NSString *iconUrl;

/**
 iconUrlHd
 */
@property(nonatomic, copy) NSString *iconUrlHd;

/**
 asset_market_cap_cny
 */
@property(nonatomic, copy) NSString *asset_market_cap_cny;

@property(nonatomic , assign) BOOL isRedpacket;

@end
