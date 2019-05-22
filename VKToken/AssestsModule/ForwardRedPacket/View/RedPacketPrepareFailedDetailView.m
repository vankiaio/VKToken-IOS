//
//  RedPacketPrepareFailedDetailView.m
//  VKToken
//
//  Created by vankiachain on 2018/8/28.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "RedPacketPrepareFailedDetailView.h"

@implementation RedPacketPrepareFailedDetailView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.confirmProcessLabel.font = [UIFont boldSystemFontOfSize:12];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyRedpacket_idToPasteboard:)];
    self.redpacket_id_label.userInteractionEnabled = YES;
    [self.redpacket_id_label addGestureRecognizer:longPressGesture];
}

- (void)copyRedpacket_idToPasteboard:(UILongPressGestureRecognizer *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = [(UILabel *)sender.view text];
    [TOASTVIEW showWithText:NSLocalizedString(@"复制成功", nil)];
}


@end
