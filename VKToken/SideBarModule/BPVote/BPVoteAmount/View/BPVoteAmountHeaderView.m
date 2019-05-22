//
//  BPVoteAmountHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2018/6/9.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BPVoteAmountHeaderView.h"



@interface BPVoteAmountHeaderView()
@property(nonatomic , strong) UILabel *vktLabel;
@property(nonatomic , strong) UIButton *editBtn;
@end



@implementation BPVoteAmountHeaderView

- (UILabel *)vktLabel{
    if (!_vktLabel) {
        _vktLabel = [[UILabel alloc] init];
        _vktLabel.text = @"VKT";
        _vktLabel.textColor = HEXCOLOR(0xFFFFFF);
        _vktLabel.font = [UIFont systemFontOfSize:14];
    }
    return _vktLabel;
}

- (UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [[UIButton alloc] init];
        [_editBtn setImage:[UIImage imageNamed:@"edit_blue"] forState:(UIControlStateNormal)];
        [_editBtn addTarget:self action:@selector(editAmountBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _editBtn;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.amountTF.backgroundColor = RGB(20, 20, 20);
    self.amountTF.textColor = HEXCOLOR(0xFFFFFF);
    [self addSubview:self.vktLabel];
    self.vktLabel.sd_layout.leftSpaceToView(self.amountTF, 2).centerYEqualToView(self.amountTF).widthIs(30).heightIs(14);
    
//    [self addSubview:self.editBtn];
//    self.editBtn.sd_layout.leftSpaceToView(self.vktLabel, 8).centerYEqualToView(self.amountTF).widthIs(13).heightEqualToWidth();
    
}

- (IBAction)amountSlider:(UISlider *)sender {

    if (self.delegate && [self.delegate respondsToSelector:@selector(sliderDidSlide:)]) {
        [self.delegate sliderDidSlide:sender];
    }
}


- (void)editAmountBtn:(UIButton *)sender {
    [self.amountTF becomeFirstResponder];
}

- (IBAction)explainLockBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(explainBtnDidClick:)]) {
        [self.delegate explainBtnDidClick:sender];
    }
}



- (void)setModel:(Account *)model{
    self.amountSlider.minimumValue = 0;
    self.amountSlider.maximumValue = model.vkt_balance.doubleValue ;
    self.amountSlider.value = 0;
    self.amountTF.text = [NSString stringWithFormat:@"%@",[NumberFormatter displayStringFromNumber:[NSNumber numberWithDouble:model.vkt_balance.doubleValue ]]];
    
    self.vktLabel.sd_layout.leftSpaceToView(self.amountTF, 2).centerYEqualToView(self.amountTF).widthIs(30).heightIs(14);
    self.stakedVKTLabel.text = [NSString stringWithFormat:@"%@ VKT", [NumberFormatter displayStringFromNumber:[NSNumber numberWithDouble:model.vkt_cpu_weight.doubleValue + model.vkt_net_weight.doubleValue ]]];
//    self.editBtn.sd_layout.leftSpaceToView(self.vktLabel, 8).centerYEqualToView(self.amountTF).widthIs(13).heightEqualToWidth();
}
@end
