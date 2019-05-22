//
//  FeedbackTableViewCell.h
//  VKToken
//
//  Created by vankiachain on 2018/1/17.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageFeedback.h"

@interface FeedbackTableViewCell : BaseTableViewCell
// 标题
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) MessageFeedback *model;
@end
