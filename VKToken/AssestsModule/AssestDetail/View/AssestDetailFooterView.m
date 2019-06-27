//
//  AssestDetailFooterView.m
//  VKToken
//
//  Created by vankiachain on 2018/5/22.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "AssestDetailFooterView.h"
#import "DeviceType.h"

@implementation AssestDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSMutableArray *arr = [NSMutableArray array];
        NSArray *imageArr = @[@"transfer_icon", @"recieve_white" , @"redpacket_icon"];
        if (LEETHEME_CURRENTTHEME_IS_BLACKBOX_MODE)  {
            arr = [NSMutableArray arrayWithObjects:NSLocalizedString(@"发起转账", nil), NSLocalizedString(@"资产收款", nil), nil];
        }else if (LEETHEME_CURRENTTHEME_IS_SOCAIL_MODE){
            arr = [NSMutableArray arrayWithObjects:NSLocalizedString(@"发起转账", nil), NSLocalizedString(@"资产收款", nil), NSLocalizedString(@"发红包", nil), nil];
        }
        CGFloat itemWidth = SCREEN_WIDTH/arr.count -30;
        CGFloat itemheight = TABBAR_HEIGHT -30;
        for (int i = 0 ; i < arr.count ; i ++) {
            UIView *baseView = [[UIView alloc] init];
            if(i == 0){
                baseView.backgroundColor = HEXCOLOR(0x08B2B8);
            }else {
                baseView.backgroundColor = HEXCOLOR(0xFFB300);
            }
            
            if([DeviceType isiPhoneX])
            {
                baseView.frame = CGRectMake((itemWidth + 20) * i + 20, -10, itemWidth, itemheight);
            }else{
                baseView.frame = CGRectMake((itemWidth + 20) * i + 20, -10, itemWidth, itemheight+30);
            }
            baseView.layer.cornerRadius = 5;
            baseView.layer.masksToBounds = YES;
            [self addSubview:baseView];
            
            UIImageView *img = [[UIImageView alloc] init];
            [img sd_setImageWithURL:String_To_URL(VALIDATE_STRING(imageArr[i])) placeholderImage:[UIImage imageNamed:@"account_default_blue"]];
            img.image = [UIImage imageNamed:imageArr[i]];
            img.frame = CGRectMake(itemWidth/2 - 35 ,16, 20, 20);
            
            UILabel *label = [[UILabel alloc] init];
            label.text = arr[i];
            label.textColor = HEXCOLOR(0xFFFFFF);
            label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18.0];
            label.frame = CGRectMake((itemWidth/2) - 35 + 16 + 11 , 16, 60, MARGIN_20);
            label.textAlignment = NSTextAlignmentLeft;
            

            
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = 1000 + i;
            btn.backgroundColor = [UIColor clearColor];
            [btn addTarget:self action:@selector(assestsFooterViewClick:) forControlEvents:(UIControlEventTouchUpInside)];
            btn.frame = baseView.bounds;
            
//            UIView *line = [[UIView alloc] init];
//            line.backgroundColor = HEXCOLOR(0xFFFFFF);
//            line.alpha = 0.26;
//            line.frame = CGRectMake(itemWidth - 1, 0, DEFAULT_LINE_HEIGHT, itemheight);

            [baseView addSubview:img];
            [baseView addSubview:label];
            [baseView addSubview:btn];
//            [baseView addSubview:line];
        }
 
    }
    return self;
}


- (void)assestsFooterViewClick:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(assestsDetailFooterViewDidClick:)]) {
        [self.delegate assestsDetailFooterViewDidClick:sender];
    }
}


@end
