//
//  InvitationCodeHeaderView.h
//  VKToken
//
//  Created by Lee on 2019/7/9.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#ifndef InvitationCodeHeaderView_h
#define InvitationCodeHeaderView_h


#import <UIKit/UIKit.h>

@protocol InvitationCodeHeaderViewDelegate<NSObject>

//- (void)ShareInvitationBtnDidClick:(UIButton *)sender;

@end

@interface InvitationCodeHeaderView : BaseView

@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *qrView;
@property (weak, nonatomic) IBOutlet UILabel *invitationCodeLabel;

/**
 邀请二维码
 */
@property (weak, nonatomic) IBOutlet UIImageView *shareInvitationQRCodeImg;
@end


#endif /* InvitationCodeHeaderView_h */
