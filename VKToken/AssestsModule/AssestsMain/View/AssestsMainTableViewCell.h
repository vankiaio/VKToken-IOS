//
//  AssestsMainTableViewCell.h
//  VKToken
//
//  Created by vankiachain on 2018/1/31.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenInfo.h"

@interface AssestsMainTableViewCell : UITableViewCell
@property(nonatomic, strong) UILabel *assestsPriceChangeLabel;
@property(nonatomic, strong) TokenInfo *model;
@end
