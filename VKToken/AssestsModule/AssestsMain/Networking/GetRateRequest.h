//
//  GetRateRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/3/22.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetRateRequest : BaseHttpsNetworkRequest
/**
 coinmarket_id
 */
@property(nonatomic, strong) NSString *coinmarket_id;
@end
