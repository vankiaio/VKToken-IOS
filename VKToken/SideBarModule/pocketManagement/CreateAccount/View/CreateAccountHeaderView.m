//
//  CreateAccountHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2017/12/12.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "CreateAccountHeaderView.h"

@interface CreateAccountHeaderView()
@property (weak, nonatomic) IBOutlet BaseTextView *tipTextView;

@end


@implementation CreateAccountHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.tipTextView.placeholder = NSLocalizedString(@"温馨提示：\n1.账号用于万加链上转账交易。\n2.万加链不存储助记词，也不能找回助记词。", nil);
}

- (IBAction)agreeTermBtn:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(agreeTermBtnDidClick:)]) {
        [self.delegate agreeTermBtnDidClick:sender];
    }
    
}
- (IBAction)createAccount:(UIButton *)sender {
//    sender.selected = !sender.isSelecteXd;
    if (self.delegate && [self.delegate respondsToSelector:@selector(createAccountBtnDidClick:)]) {
        [self.delegate createAccountBtnDidClick:sender];
    }
}
- (IBAction)privacyPolicy:(BaseButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(privacyPolicyBtnDidClick:)]) {
        [self.delegate privacyPolicyBtnDidClick:sender];
    }
}


@end
