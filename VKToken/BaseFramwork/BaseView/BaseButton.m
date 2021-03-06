//
//  BaseButton.m
//  VKToken
//
//  Created by vankiachain on 2018/5/18.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lee_theme
        .LeeConfigBackgroundColor(@"baseView_background_color")
        .LeeAddButtonTitleColor(SOCIAL_MODE, HEXCOLOR(0xB0B0B0), UIControlStateNormal)
        .LeeAddButtonTitleColor(BLACKBOX_MODE, HEXCOLOR(0xB0B0B0), UIControlStateNormal);
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lee_theme
    .LeeConfigBackgroundColor(@"baseView_background_color")
    .LeeAddButtonTitleColor(SOCIAL_MODE, HEXCOLOR(0xB0B0B0), UIControlStateNormal)
    .LeeAddButtonTitleColor(BLACKBOX_MODE, HEXCOLOR(0xB0B0B0), UIControlStateNormal);
}
@end
