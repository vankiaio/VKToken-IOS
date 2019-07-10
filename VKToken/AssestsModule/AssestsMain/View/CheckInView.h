//
//  CheckInView.h
//  VKToken
//
//  Created by vankiachain on 2017/12/7.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInView : UIView
@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *getAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkInLabel;

/**
 修改圆角用
 */
@property (weak, nonatomic) IBOutlet UIView *mainView;

@end
