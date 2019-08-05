//
//  ImportAccountWithoutAccountNameDoublePrivateKeyModeHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2018/11/19.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "ImportAccountWithoutAccountNameMnemonicModeHeaderView.h"


@interface ImportAccountWithoutAccountNameMnemonicModeHeaderView ()

@property (weak, nonatomic) IBOutlet BaseLabel1 *tipLabel;

@property (weak, nonatomic) IBOutlet BaseConfirmButton *confirmBtn;

@end

@implementation ImportAccountWithoutAccountNameMnemonicModeHeaderView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.textView1.contentInset = UIEdgeInsetsMake(MARGIN_10, MARGIN_15, MARGIN_10, MARGIN_15);
    
    self.tipLabel.text = NSLocalizedString(@"请输入助记词：", nil);
    [self.confirmBtn setTitle:NSLocalizedString(@"确认",  nil) forState:(UIControlStateNormal)];
    self.confirmBtn.layer.masksToBounds = YES;
    self.confirmBtn.layer.cornerRadius = 5;
    
    self.textView1.placeholder = NSLocalizedString(@"请输入助记词：", nil);
}


- (IBAction)confirmBtnClick:(BaseConfirmButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ImportAccountWithoutAccountNameMnemonicModeHeaderViewConfirmBtnDidClick)]) {
        [self.delegate ImportAccountWithoutAccountNameMnemonicModeHeaderViewConfirmBtnDidClick];
    }
}

@end
