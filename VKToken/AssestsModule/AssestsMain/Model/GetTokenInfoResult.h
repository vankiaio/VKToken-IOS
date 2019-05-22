//
//  GetTokenInfoResult.h
//  VKToken
//
//  Created by vankiachain on 2018/7/19.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseResult.h"
#import "TokenInfo.h"

@interface GetTokenInfoResult : BaseResult

@property(nonatomic, strong) NSMutableArray *data;

@end
