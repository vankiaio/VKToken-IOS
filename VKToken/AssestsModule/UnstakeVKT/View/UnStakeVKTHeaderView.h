//
//  UnStakeVKTHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2018/6/15.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountResult.h"
#import "Account.h"

@protocol UnStakeVKTHeaderViewDelegate<NSObject>
- (void)confirmUnStakeBtnDidClick;
@end


@interface UnStakeVKTHeaderView : BaseView

@property(nonatomic , strong) AccountResult *model;

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property(nonatomic, weak) id<UnStakeVKTHeaderViewDelegate> delegate;
@end
