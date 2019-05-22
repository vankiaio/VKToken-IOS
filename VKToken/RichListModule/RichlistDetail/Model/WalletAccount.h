//
//  WalletAccount.h
//  VKToken
//
//  Created by vankiachain on 2018/1/31.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletAccount : NSObject
@property(nonatomic, strong) NSString *vktAccountName;

@property(nonatomic, strong) NSNumber *isMainAccount;


@property(nonatomic , assign) BOOL selected;
@end
