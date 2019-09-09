//
//  CheckInView.m
//  VKToken
//
//  Created by vankiachain on 2017/12/7.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "CheckInView.h"

@interface CheckInView()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *upBackgroundView;
@end

@implementation CheckInView

- (void)awakeFromNib{
    [super awakeFromNib];
    _mainView.layer.cornerRadius = 10;
    _mainView.layer.masksToBounds = true;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    self.signedinSuccessLabel.text = NSLocalizedString(@"签到成功", nil);
    
//    [self.bottomBackgroundView addSubview:self.socialSharePanelView];
}

- (void)dismiss{
    [self removeFromSuperview];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isEqual:self.upBackgroundView] || [touch.view isEqual:self.bottomBackgroundView]) {
        return NO;
        
    }else{
        return YES;
    }
}

@end
