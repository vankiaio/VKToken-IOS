//
//  AccountQRCodeManagementHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2018/7/27.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AccountQRCodeManagementHeaderViewDelegate<NSObject>
- (void)copyNameBtnClick;
@end


@interface AccountQRCodeManagementHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImg;
@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property(nonatomic, weak) id<AccountQRCodeManagementHeaderViewDelegate> delegate;

@end
