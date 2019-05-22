//
//  AssestLockRecordsHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2017/12/11.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AssestLockRecordsHeaderViewDelegate<NSObject>
@optional
//- (void)selectAccountBtnDidClick:(UIButton *)sender;

@end

@interface AssestLockRecordsHeaderView : BaseView
@property (weak, nonatomic) IBOutlet UILabel *lockedAmountLabel;
@property(nonatomic, weak) id<AssestLockRecordsHeaderViewDelegate> delegate;

@end
