//
//  BaseLabel.m
//  VKToken
//
//  Created by vankiachain on 2018/5/18.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseLabel.h"

@implementation BaseLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lee_theme.LeeConfigTextColor(@"common_font_color_1");
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lee_theme.LeeConfigTextColor(@"common_font_color_1");
}

@end
