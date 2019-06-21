//
//  BaseTextField.m
//  VKToken
//
//  Created by vankiachain on 2018/5/18.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.lee_theme
        .LeeConfigBackgroundColor(@"baseView_background_color")
        .LeeConfigTextColor(@"common_font_color_1")
        .LeeAddPlaceholderColor(SOCIAL_MODE, HEXCOLOR(0xDDDDDD))
        .LeeAddPlaceholderColor(BLACKBOX_MODE, RGBACOLOR(221, 221, 221, 0.4));
        self.font =  [UIFont boldSystemFontOfSize:15.0f];
        
        
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lee_theme
    .LeeConfigBackgroundColor(@"baseView_background_color")
    .LeeConfigTextColor(@"common_font_color_1")
    .LeeAddPlaceholderColor(SOCIAL_MODE, HEXCOLOR(0xDDDDDD))
    .LeeAddPlaceholderColor(BLACKBOX_MODE, RGBACOLOR(221, 221, 221, 0.4));
    self.font =  [UIFont boldSystemFontOfSize:15.0f];
    

}

@end
