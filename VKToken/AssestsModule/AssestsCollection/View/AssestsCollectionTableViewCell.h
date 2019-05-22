//
//  AssestsCollectionTableViewCell.h
//  VKToken
//
//  Created by vankiachain on 2018/10/20.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TokenInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface AssestsCollectionTableViewCell : BaseTableViewCell

@property(nonatomic , strong) TokenInfo *model;

@end

NS_ASSUME_NONNULL_END
