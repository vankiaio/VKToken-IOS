//
//  CustomAssestsHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2018/7/17.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "CustomAssestsHeaderView.h"

@implementation CustomAssestsHeaderView

- (IBAction)confirmBtnClick:(BaseConfirmButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(confirmBtnDidClick)]) {
        [self.delegate confirmBtnDidClick];
    }
}



@end
