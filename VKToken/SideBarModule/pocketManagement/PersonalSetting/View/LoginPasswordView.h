//
//  LoginPasswordView.h
//  VKToken
//
//  Created by vankiachain on 2017/12/13.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginPasswordViewDelegate<NSObject>
- (void)cancleBtnDidClick:(UIButton *)sender;
- (void)confirmBtnDidClick:(UIButton *)sender;
@end

@interface LoginPasswordView : UIView
@property(nonatomic, weak) id<LoginPasswordViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *inputPasswordTF;

@end
