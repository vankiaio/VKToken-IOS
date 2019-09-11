//
//  TransferDetailsViewController.h
//  VKToken
//
//  Created by vankiachain on 2018/8/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseViewController.h"
#import "TransactionRecord.h"

@interface TransferDetailsViewController : BaseViewController
@property(nonatomic , strong) NSString *currentAccountName;
@property(nonatomic , strong) TransactionRecord *model;
@end
