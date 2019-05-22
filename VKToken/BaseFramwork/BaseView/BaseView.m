//
//  BaseView.m
//  VKToken
//
//  Created by vankiachain on 17/05/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lee_theme.LeeConfigBackgroundColor(@"baseView_background_color");
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.lee_theme.LeeConfigBackgroundColor(@"baseView_background_color");
}

@end
