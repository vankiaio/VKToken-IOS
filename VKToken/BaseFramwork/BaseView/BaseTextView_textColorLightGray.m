//
//  BaseTextView_textColorLightGray.m
//  VKToken
//
//  Created by vankiachain on 2018/10/31.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseTextView_textColorLightGray.h"

@implementation BaseTextView_textColorLightGray

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lee_theme.LeeConfigBackgroundColor(@"baseView_background_color")
        .LeeAddTextColor(SOCIAL_MODE, HEXCOLOR(0x999999))
        .LeeAddTextColor(BLACKBOX_MODE, RGBA(153, 153, 153, 0.4));
        
        if (LEETHEME_CURRENTTHEME_IS_SOCAIL_MODE) {
            self.placeholderColor = HEXCOLOR(0xDDDDDD);
            
        }else if (LEETHEME_CURRENTTHEME_IS_BLACKBOX_MODE){
            self.placeholderColor = HEX_RGB_Alpha(0xDDDDDD, 0.4);
            
        }
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.lee_theme.LeeConfigBackgroundColor(@"baseView_background_color")
    .LeeAddTextColor(SOCIAL_MODE, HEXCOLOR(0x999999))
    .LeeAddTextColor(BLACKBOX_MODE, RGBA(153, 153, 153, 0.4));
    
    if (LEETHEME_CURRENTTHEME_IS_SOCAIL_MODE) {
        self.placeholderColor = HEXCOLOR(0xDDDDDD);
        
    }else if (LEETHEME_CURRENTTHEME_IS_BLACKBOX_MODE){
        self.placeholderColor = HEX_RGB_Alpha(0xDDDDDD, 0.4);
        
    }
}


@end
