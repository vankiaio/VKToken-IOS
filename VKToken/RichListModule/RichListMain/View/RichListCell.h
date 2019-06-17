//
//  RichListCell.h
//  VKToken
//
//  Created by vankiachain on 2017/12/26.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Follow;
@class WalletAccount;
@class AccountInfo;
@interface RichListCell : BaseTableViewCell

@property(nonatomic, strong) Follow *model;



/**
 VKToken 富豪榜钱包
 */
@property(nonatomic, strong) Follow *walletModel;


/**
 网络解析的 account
 */
@property(nonatomic, strong) WalletAccount *walletAccount;


/**
 本地存的 account
 */
@property(nonatomic, strong) AccountInfo *accountInfo;
@end
