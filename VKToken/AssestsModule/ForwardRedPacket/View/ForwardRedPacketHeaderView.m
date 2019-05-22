//
//  ForwardRedPacketHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2017/12/6.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "ForwardRedPacketHeaderView.h"

@implementation ForwardRedPacketHeaderView

- (IBAction)continueSendRedPacket:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(continueSendRedPacketBtnDidClick:)]) {
        [self.delegate continueSendRedPacketBtnDidClick:sender];
    }
}


@end
