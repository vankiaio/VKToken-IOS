//
//  TransferRecordsHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2018/8/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "TransferRecordsHeaderView.h"

@implementation TransferRecordsHeaderView

- (IBAction)selectAssests:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAssestsBtnDidClick:)]) {
        [self.delegate selectAssestsBtnDidClick: sender];
    }
}


@end
