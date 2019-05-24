//
//  VKTButton.m
//  VKToken
//
//  Created by 李轶 on 2019/5/22.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import "VKTButton.h"

@implementation VKTButton


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.width = 230;
    self.height = 50;
    self.titleLabel.frame = CGRectMake(0, 0, self.width, self.height);
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:17/255.0 green:160/255.0 blue:165/255.0 alpha:0.25];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;

        //设置圆角的大小
        self.layer.cornerRadius = 5;
        //此行代码必须有（UIView例外）
        self.layer.masksToBounds = YES;

//        [self setTitle:@"按钮" forState:UIControlStateNormal];
//        NSMutableAttributedString *vktbtntxt = [[NSMutableAttributedString alloc] initWithString:@"创建账号" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 17], NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
//        self.titleLabel.attributedText = vktbtntxt;
    }
    return self;
}



@end
