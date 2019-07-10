//
//  BaseConfirmButton.m
//  VKToken
//
//  Created by vankiachain on 2018/5/28.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseConfirmButton.h"

@implementation BaseConfirmButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lee_theme
        .LeeAddBackgroundColor(SOCIAL_MODE, HEXCOLOR(0x08B2B8))
        .LeeAddBackgroundColor(BLACKBOX_MODE, HEXCOLOR(0x08B2B8));
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lee_theme
    .LeeAddBackgroundColor(SOCIAL_MODE, HEXCOLOR(0x08B2B8))
    .LeeAddBackgroundColor(BLACKBOX_MODE, HEXCOLOR(0x08B2B8));
}
@end
