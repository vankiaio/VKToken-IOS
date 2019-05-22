//
//  SimpleWalletLoginHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2018/9/29.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SimpleWalletLoginHeaderViewDelegate<NSObject>
- (void)confirmAuthorizationBtnDidClick;
@end


@interface SimpleWalletLoginHeaderView : UIView

@property(nonatomic, weak) id<SimpleWalletLoginHeaderViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UIImageView *dappAvatarView;
@property (weak, nonatomic) IBOutlet BaseLabel *dappNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vktAccountNameLabel;
@property (weak, nonatomic) IBOutlet BaseConfirmButton *confirmBtn;


@end
