//
//  BaseLabel1.m
//  VKToken
//
//  Created by vankiachain on 2018/5/18.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseLabel1.h"

@implementation BaseLabel1

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.lee_theme.LeeAddTextColor(SOCIAL_MODE, HEXCOLOR(0x999999)).LeeAddTextColor(BLACKBOX_MODE, RGBACOLOR(153, 153, 153, 1.0));
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lee_theme.LeeAddTextColor(SOCIAL_MODE, HEXCOLOR(0x999999)).LeeAddTextColor(BLACKBOX_MODE, RGBACOLOR(153, 153, 153, 1.0));
}

@end
