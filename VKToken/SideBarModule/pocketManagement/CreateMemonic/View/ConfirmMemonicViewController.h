//
//  ConfirmPrivateKeyViewController.h
//  UIProject
//
//  Created by lee on 07/02/2019.
//  Copyright © 2018 vankia. All rights reserved.
//

#import "BaseViewController.h"

@class WalletModel;

@interface ConfirmMemonicViewController : BaseViewController

@property (nonatomic, strong) WalletModel *walletModel;
@property (nonatomic, strong) NSArray *memonicWords;

@end
