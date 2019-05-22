//
//  PushTransactionRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/3/21.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushTransactionRequest : BaseHttpsNetworkRequest

@property(nonatomic, copy) NSString *packed_trx;
@property(nonatomic, copy) NSString *signatureStr;


@end
