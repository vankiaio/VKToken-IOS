//
//  AssestLockRecordTableViewCell.h
//  VKToken
//
//  Created by vankiachain on 2018/2/7.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssestLockRecord.h"

@interface AssestLockRecordTableViewCell : BaseTableViewCell
@property(nonatomic , copy) NSString *currentAccountName;
@property(nonatomic, strong) AssestLockRecord *model;
@end
