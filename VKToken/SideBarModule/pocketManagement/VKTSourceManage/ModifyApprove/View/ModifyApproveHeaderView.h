//
//  ModifyApproveView.h
//  VKToken
//
//  Created by vankiachain on 2018/6/22.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseHeaderView.h"

@protocol ModifyApproveHeaderViewDelegate<NSObject>
- (void)confirmModifyBtnDidClick:(UIButton *)sender;
- (void)modifyApproveSliderDidSlide:(UISlider *)sender;
@end


@interface ModifyApproveHeaderView : BaseHeaderView

@property (weak, nonatomic) IBOutlet UISlider *modifyApproveSlider;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet BaseLabel1 *predictLabel;
@property (weak, nonatomic) IBOutlet BaseConfirmButton *confirmBtn;
@property(nonatomic, weak) id<ModifyApproveHeaderViewDelegate> delegate;

@end
