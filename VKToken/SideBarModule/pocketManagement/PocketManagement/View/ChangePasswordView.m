//
//  ChangePasswordView.m
//  VKToken
//
//  Created by vankiachain on 2018/2/25.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "ChangePasswordView.h"

@interface ChangePasswordView()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *upBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end


@implementation ChangePasswordView
- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
            //设置圆角的大小
    self.confirmButton.layer.cornerRadius = 5.0f;
    //此行代码必须有（UIView例外）
    self.confirmButton.layer.masksToBounds = YES;
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isEqual:self.upBackgroundView]) {
        return NO;
        
    }else{
        return YES;
    }
}
- (IBAction)cancleBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancleBtnDidClick:)]) {
        [self.delegate cancleBtnDidClick:sender];
    }
}

- (IBAction)confirmBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmPasswordBtnDidClick:)]) {
        [self.delegate confirmPasswordBtnDidClick:sender];
    }
}
- (void)dismiss{
    [self removeFromSuperview];
}
@end
