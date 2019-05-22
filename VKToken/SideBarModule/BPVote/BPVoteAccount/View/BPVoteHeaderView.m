//
//  BPVoteHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2018/6/7.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BPVoteHeaderView.h"
#import "Account.h"

@interface BPVoteHeaderView()


@end


@implementation BPVoteHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];

}

- (IBAction)changeAccountBtn:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeAccountBtnDidClick:)]) {
        [self.delegate changeAccountBtnDidClick:sender];
    }
}



-(void)setModel:(AccountResult *)model{
    self.accountNameLabel.text = model.data.account_name;
    self.balanceLabel.text = [NSString stringWithFormat:@"%@ : %@VKT", NSLocalizedString(@"余额", nil), [NumberFormatter displayStringFromNumber:[NSNumber numberWithDouble:model.data.vkt_balance.doubleValue ]]];
    self.balanceOfVotedLabel.text = [NSString stringWithFormat:@"%@ VKT", [NumberFormatter displayStringFromNumber:[NSNumber numberWithDouble:model.data.vkt_cpu_weight.doubleValue + model.data.vkt_net_weight.doubleValue]]];
}



@end
