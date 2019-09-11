//
//  RecieveHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2017/12/5.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecieveHeaderViewDelegate<NSObject>

- (void)selectAccountBtnDidClick:(UIButton *)sender;
- (void)selectAssestsBtnDidClick:(UIButton *)sender;
- (void)createQRCodeBtnDidClick:(UIButton *)sender;

@end

@interface RecieveHeaderView : BaseView

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *qrView;
@property (weak, nonatomic) IBOutlet UIView *accountView;
@property (weak, nonatomic) IBOutlet UILabel *assestChooserLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UIImageView *assetLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *accountTFLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UIButton *generateQRCodeBtn;
/**
 收款二维码
 */
@property (weak, nonatomic) IBOutlet UIImageView *recieveAssestsQRCodeImg;
@property(nonatomic, weak) id<RecieveHeaderViewDelegate> delegate;
@end
