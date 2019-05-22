//
//  MessageCenterTableViewCell.h
//  VKToken
//
//  Created by vankiachain on 2018/1/18.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCenter.h"

@interface MessageCenterTableViewCell : BaseTableViewCell
@property(nonatomic, strong) MessageCenter *model;
@end
