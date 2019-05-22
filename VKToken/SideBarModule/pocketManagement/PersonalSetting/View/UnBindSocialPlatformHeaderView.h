//
//  UnBindSocialPlatformHeaderView.h
//  VKToken
//
//  Created by vankiachain on 08/04/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UnBindSocialPlatformHeaderViewDelegate<NSObject>
- (void)unBindBtnDidClick:(UIButton *)sender;
@end

@interface UnBindSocialPlatformHeaderView : BaseView
@property(nonatomic, weak) id<UnBindSocialPlatformHeaderViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *platformImg;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet UIButton *bindBtn;

@end
