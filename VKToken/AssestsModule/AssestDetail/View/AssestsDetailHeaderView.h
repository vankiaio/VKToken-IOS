//
//  AssestsDetailHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2017/12/7.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AssestsDetailHeaderViewDelegate<NSObject>
- (IBAction)transferBtnDidClick;
- (IBAction)recieveBtnDidClick;
- (IBAction)redPacketBtnDidClick;
- (IBAction)assetsLocksBtnDidClick:(UIButton *)sender;
- (IBAction)transferClassTabBarDidClick:(UITabBarItem *)sender;
- (IBAction)copyAccountBtnDidClick:(UIButton *)sender;
@end

@class TendencyChartView;
@interface AssestsDetailHeaderView : BaseView
@property(nonatomic, weak) id<AssestsDetailHeaderViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet TendencyChartView *tendencyChartView;
@property (weak, nonatomic) IBOutlet UILabel *fluctuateLabel;
@property (weak, nonatomic) IBOutlet UILabel *lockedLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *Assest_balance_Label;
@property (weak, nonatomic) IBOutlet UILabel *assest_value_label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@end
