//
//  ExportPrivateKeyView.m
//  VKToken
//
//  Created by vankiachain on 2017/12/13.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "ExportMnemonicView.h"


@interface ExportMnemonicView()<UIGestureRecognizerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *upBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *contentTextBaseView;

@property (weak, nonatomic) IBOutlet UIButton *generateQRCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *privateKeyCopyBtn;


@end

@implementation ExportMnemonicView

- (UIImageView *)QRCodeimg{
    if (!_QRCodeimg) {
        _QRCodeimg = [[UIImageView alloc] init];
    }
    return _QRCodeimg;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    
    [self.upBackgroundView addSubview:self.QRCodeimg];
    CGFloat itemWidth = 150;
    self.QRCodeimg.frame = CGRectMake((290/2) - (itemWidth / 2), 80, itemWidth, itemWidth);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    self.contentTextBaseView.lee_theme
    .LeeAddBackgroundColor(SOCIAL_MODE, HEXCOLOR(0xF8F8F8))
    .LeeAddBackgroundColor(BLACKBOX_MODE, HEXCOLOR(0xF8F8F8));
    
    self.contentTextView.lee_theme
    .LeeAddBackgroundColor(SOCIAL_MODE, HEXCOLOR(0xF8F8F8))
    .LeeAddBackgroundColor(BLACKBOX_MODE, HEXCOLOR(0xF8F8F8));
    
    self.contentTextView.lee_theme
    .LeeAddTextColor(SOCIAL_MODE, HEXCOLOR(0x2A2A2A))
    .LeeAddTextColor(BLACKBOX_MODE, HEXCOLOR(0x2A2A2A));
    
    self.contentTextView.delegate = self;
}

- (void)dismiss{
    [self removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(exportMnemonicViewShouldDismiss)]) {
        [self.delegate exportMnemonicViewShouldDismiss];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isEqual:self.upBackgroundView]) {
        return NO;
        
    }else{
        return YES;
    }
}

- (IBAction)generateQRCodeBtn:(UIButton *)sender {
    self.contentTextView.hidden = YES;
    self.QRCodeimg.hidden = NO;
    self.contentTextBaseView.hidden = YES;

    if (self.delegate && [self.delegate respondsToSelector:@selector(genetateQRBtnDidClick:)]) {
        [self.delegate genetateQRBtnDidClick:sender];
    }
}

- (IBAction)copyOwnerMnemonicBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(copyOwnerPrivateKeyBtnDidClick)]) {
        [self.delegate copyOwnerPrivateKeyBtnDidClick];
    }
}


- (IBAction)copyActiveMnemonicBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(copyActivePrivateKeyBtnDidClick)]) {
        [self.delegate copyActivePrivateKeyBtnDidClick];
    }
}


- (IBAction)copyBtn:(UIButton *)sender {
    
    self.QRCodeimg.hidden = YES;
    self.contentTextView.hidden = NO;
    self.contentTextBaseView.hidden = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(copyMnemonicBtnDidClick:)]) {
        [self.delegate copyMnemonicBtnDidClick:sender];
    }
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}




@end
