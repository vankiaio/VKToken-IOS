//
//  BaseSlimLineView.m
//  VKToken
//
//  Created by vankiachain on 2018/5/23.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseSlimLineView.h"

@implementation BaseSlimLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lee_theme.LeeAddBackgroundColor(SOCIAL_MODE, HEXCOLOR(0xEEEEEE)).LeeAddBackgroundColor(BLACKBOX_MODE, HEX_RGB_Alpha(0xEEEEEE, 1.0));
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lee_theme.LeeAddBackgroundColor(SOCIAL_MODE, HEXCOLOR(0xEEEEEE)).LeeAddBackgroundColor(BLACKBOX_MODE, HEX_RGB_Alpha(0xEEEEEE, 1.0));
}


@end
