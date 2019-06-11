//
//  SelectAccountView.h
//  VKToken
//
//  Created by vankiachain on 2018/1/18.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SelectAccountViewDelegate<NSObject>
- (void)backgroundViewDidClick;
- (void)selectAccountBtnDidClick:(UIButton *)sender;
- (void)understandBtnDidClick:(UIButton *)sender;
@end

@interface SelectAccountView : UIView
@property (weak, nonatomic) IBOutlet UILabel *accountChooseLabel;
@property(nonatomic, weak) id<SelectAccountViewDelegate> delegate;
@end