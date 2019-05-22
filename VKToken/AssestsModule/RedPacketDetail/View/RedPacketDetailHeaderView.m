//
//  RedPacketDetailHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2018/7/2.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "RedPacketDetailHeaderView.h"

@implementation RedPacketDetailHeaderView

- (IBAction)sendRedPacketBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendRedPacketBtnDidClick)]) {
        [self.delegate sendRedPacketBtnDidClick];
    }
}

@end
