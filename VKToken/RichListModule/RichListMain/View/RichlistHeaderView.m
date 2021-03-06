//
//  RichlistHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2017/12/4.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "RichlistHeaderView.h"

@implementation RichlistHeaderView

- (IBAction)searchFriends:(UIButton *)sender {
    if (!self.onSearchFriendsBlock) {
        return;
    }
    self.onSearchFriendsBlock();
}

- (IBAction)enterprise:(UIButton *)sender {
    if (!self.onEnterPriseBlock) {
        return;
    }
    self.onEnterPriseBlock();
}

- (IBAction)pEList:(UIButton *)sender {
    if (!self.onPeListBlock) {
        return;
    }
    self.onPeListBlock();
}


@end
