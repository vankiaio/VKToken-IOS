//
//  CurrencySettingService.h
//  VKToken
//
//  Created by vankiachain on 2019/6/8.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "GetCurrenciesListRequest.h"

@interface CurrencySettingService : BaseService

@property(nonatomic, strong) GetCurrenciesListRequest *getCurrenciesListRequest;
- (void)buildNextPageDataSource:(CompleteBlock)complete;

@end
