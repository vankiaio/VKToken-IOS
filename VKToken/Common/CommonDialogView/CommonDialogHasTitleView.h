//
//  CommonDialogHasTitleView.h
//  VKToken
//
//  Created by vankiachain on 2018/9/25.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommonDialogHasTitleViewDelegate<NSObject>
- (void)commonDialogHasTitleViewSkipBtnDidClick:(UIButton *)sender;
- (void)commonDialogHasTitleViewConfirmBtnDidClick:(UIButton *)sender;
- (void)commonDialogHasTitleViewWillDismiss;
@end


@interface CommonDialogHasTitleView : UIView

@property(nonatomic , strong) OptionModel *model;
@property(nonatomic , strong) UITextView *contentTextView;
@property(nonatomic , copy) NSString *comfirmBtnText;
@property(nonatomic, weak) id<CommonDialogHasTitleViewDelegate> delegate;

@end
