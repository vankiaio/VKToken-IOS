//
//  RedPacketPrepareDetailView.h
//  VKToken
//
//  Created by vankiachain on 2018/8/28.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedPacketPrepareDetailView : UIView

@property (weak, nonatomic) IBOutlet UILabel *redpacket_id_label;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *refundTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tx_id_label;
@property (weak, nonatomic) IBOutlet UILabel *blockNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *confirmProcessLabel;



@end
