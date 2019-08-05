//
//  ImportAccountWithoutAccountNameDoublePrivateKeyModeHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2018/11/19.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ImportAccountWithoutAccountNameMnemonicModeHeaderViewDelegate <NSObject>
- (void)ImportAccountWithoutAccountNameMnemonicModeHeaderViewConfirmBtnDidClick;

@end

@interface ImportAccountWithoutAccountNameMnemonicModeHeaderView : UIView
@property(nonatomic, weak) id<ImportAccountWithoutAccountNameMnemonicModeHeaderViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UITextView *textView1;

@end

NS_ASSUME_NONNULL_END
