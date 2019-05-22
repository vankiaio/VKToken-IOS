//
//  GetTransactionByIdRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/9/26.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"

@interface GetTransactionByIdRequest : BaseNetworkRequest


@property(nonatomic , copy) NSString *transactionId;

@end
