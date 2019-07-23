//
//  CheckInView.h
//  VKToken
//
//  Created by vankiachain on 2017/12/7.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInView : UIView
@property (weak, nonatomic) IBOutlet BaseLabel1 *signedinSuccessLabel;
@property (weak, nonatomic) IBOutlet BaseLabel1 *accountName;
@property (weak, nonatomic) IBOutlet BaseLabel1 *todayScoreLabel;
@property (weak, nonatomic) IBOutlet BaseLabel1 *totalScoreLabel;
/**
 修改圆角用
 */
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
