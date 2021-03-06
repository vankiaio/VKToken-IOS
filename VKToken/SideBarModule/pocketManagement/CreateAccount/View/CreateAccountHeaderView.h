//
//  CreateAccountHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2017/12/12.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateAccountHeaderViewDelegate<NSObject>
@optional
- (void)agreeTermBtnDidClick:(UIButton *)sender;
- (void)createAccountBtnDidClick:(UIButton *)sender;
- (void)privacyPolicyBtnDidClick:(UIButton *)sender;
@end

@interface CreateAccountHeaderView : BaseView
@property (weak, nonatomic) IBOutlet UITextField *accountNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordToSet;
@property (weak, nonatomic) IBOutlet UITextField *passwordToConfirm;
@property (weak, nonatomic) IBOutlet UITextField *inviteCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *agreeItemBtn;
@property(nonatomic, weak) id<CreateAccountHeaderViewDelegate> delegate;
@end
