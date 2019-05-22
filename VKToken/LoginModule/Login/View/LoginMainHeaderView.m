//
//  LoginMainHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2018/7/26.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "LoginMainHeaderView.h"

@interface LoginMainHeaderView()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollHeight;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImg;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIView *upBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UILabel *privacyPolicyLabel;


@property (weak, nonatomic) IBOutlet UIButton *phoneLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *blackboxModeBtn;

@end


@implementation LoginMainHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
   
    //    if ([DeviceType getIsIpad]) {
    //        self.scrollHeight.constant = 150;
    //    }
//    self.scrollHeight.constant = 700;
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.colors = @[(__bridge id)HEXCOLOR(0x3083ff).CGColor, (__bridge id)HEXCOLOR(0x1566df).CGColor];
    layer.locations = @[@(0.5f), @(1.0f)];
    [self.upBackgroundView.layer addSublayer:layer];
    
    [self.upBackgroundView bringSubviewToFront:self.label1];
    [self.upBackgroundView bringSubviewToFront:self.label2];
    [self.upBackgroundView bringSubviewToFront:self.img];
    [self.upBackgroundView bringSubviewToFront:self.rightArrowImg];

    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
        // Fallback on earlier versions
    }
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString: NSLocalizedString(@"登录即代表同意《用户协议及隐私政策》", nil)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:
     HEXCOLOR(0x999999) range:NSMakeRange(0,attrStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, attrStr.length)];
    
    if ([NSBundle isChineseLanguage]) {
        [attrStr addAttribute:NSUnderlineStyleAttributeName value:
         [NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(attrStr.length-10, 9)]; // 下划线
        [attrStr addAttribute:NSUnderlineColorAttributeName value:
         HEXCOLOR(0x999999) range:NSMakeRange(attrStr.length-10, 9)]; // 下划线颜色
    }
    
    
    self.privacyPolicyLabel.attributedText = attrStr;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(privacyPolicy)];
    self.privacyPolicyLabel.userInteractionEnabled = YES;
    [self.privacyPolicyLabel addGestureRecognizer:tap];
    
    self.phoneLoginBtn.layer.borderWidth = 1;
    self.phoneLoginBtn.layer.borderColor = HEXCOLOR(0xE4E4E4).CGColor;
    self.phoneLoginBtn.sd_cornerRadius = @2;
    
    self.blackboxModeBtn.layer.borderWidth = 1;
    self.blackboxModeBtn.layer.borderColor = HEXCOLOR(0xE4E4E4).CGColor;
    self.blackboxModeBtn.sd_cornerRadius = @2;
    
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
}


- (IBAction)loginBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginBtnDidClick:)]) {
        [self.delegate loginBtnDidClick:sender];
    }
}

- (IBAction)wechatLoginBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wechatLoginBtnDidClick:)]) {
        [self.delegate wechatLoginBtnDidClick:sender];
    }
}

- (IBAction)changeToBlackBoxMode:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeToBlackBoxMode)]) {
        [self.delegate changeToBlackBoxMode];
    }
}


- (void)privacyPolicy{
    if (self.delegate && [self.delegate respondsToSelector:@selector(privacyPolicyLabelDidTap)]) {
        [self.delegate privacyPolicyLabelDidTap];
    }
}

@end
