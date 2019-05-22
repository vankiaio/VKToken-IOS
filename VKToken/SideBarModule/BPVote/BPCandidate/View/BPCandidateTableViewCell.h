//
//  BPCandidateTableViewCell.h
//  VKToken
//
//  Created by vankiachain on 2018/6/9.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPCandidateModel.h"


@interface BPCandidateTableViewCell : BaseTableViewCell
@property(nonatomic , strong) BPCandidateModel *model;
@property(nonatomic, copy) void(^onAvatarViewClick)();
@end
