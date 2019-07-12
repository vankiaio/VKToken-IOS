//
//  ExportPrivateKeyView.h
//  VKToken
//
//  Created by vankiachain on 2017/12/13.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExportMnemonicViewDelegate<NSObject>
- (void)genetateQRBtnDidClick:(UIButton *)sender;
- (void)copyMnemonicBtnDidClick:(UIButton *)sender;

- (void)exportMnemonicViewShouldDismiss;

- (void)copyOwnerPrivateKeyBtnDidClick;
- (void)copyActivePrivateKeyBtnDidClick;
@end

@interface ExportMnemonicView : UIView
@property (weak, nonatomic) IBOutlet UILabel *privateKeyLabel;
@property(nonatomic, weak) id<ExportMnemonicViewDelegate> delegate;
@property(nonatomic, strong) UIImageView *QRCodeimg;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@end
