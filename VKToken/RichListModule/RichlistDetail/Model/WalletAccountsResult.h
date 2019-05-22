//
//  WalletAccountsResult.h
//  VKToken
//
//  Created by vankiachain on 2018/1/31.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletAccountsResult : NSObject

@property(nonatomic, strong) NSString *code;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) NSMutableArray *data;

@end
