//
//  CustomAssestsTableViewCell.h
//  VKToken
//
//  Created by vankiachain on 2018/7/17.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CustomToken.h"

@interface CustomAssestsTableViewCell : BaseTableViewCell
@property(nonatomic , strong) CustomToken *model;

@property(nonatomic , copy)void(^onTrashImageDidTapBlock)(CustomToken *);

@end
