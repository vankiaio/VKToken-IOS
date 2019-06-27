//
//  AssestsDetailHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2017/12/7.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "AssestsDetailHeaderView.h"
#import "TendencyChartView.h"

@interface AssestsDetailHeaderView()
@property (weak, nonatomic) IBOutlet TendencyChartView *chartView;

@end


@implementation AssestsDetailHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.chartView.frame = CGRectMake(20, 98, SCREEN_WIDTH - MARGIN_20 * 2, 55);
    self.imageView.layer.cornerRadius = 10;
    self.tabBar.barStyle = UIBarStyleDefault;// 黑 和 白
    self.tabBar.translucent = YES;// 透明属性
    self.tabBar.delegate = self;
    self.tabBar.selectedImageTintColor = HEXCOLOR(0x5BD2D6);// 选中图片的 tintColor
    [self.tabBar setSelectedItem:self.tabBar.items[0]];
    for(UITabBarItem *tabitem in  self.tabBar.items)
        
    {
        [tabitem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"PingFangSC-Semibold" size:16.0], UITextAttributeFont, nil]
                               forState:UIControlStateNormal];
    }
}

- (IBAction)transferBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(transferBtnDidClick)]) {
        [self.delegate transferBtnDidClick];
    }
    
    
}

- (IBAction)recieveBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(recieveBtnDidClick)]) {
        [self.delegate recieveBtnDidClick];
    }
}

- (IBAction)redPacketBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(redPacketBtnDidClick)]) {
        [self.delegate redPacketBtnDidClick];
    }
}

- (IBAction)assetsLocksBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(assetsLocksBtnDidClick:)]) {
        [self.delegate assetsLocksBtnDidClick:sender];
    }
}

- (IBAction)copyAccountBtn:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(copyAccountBtnDidClick:)]) {
        [self.delegate copyAccountBtnDidClick:sender];
    }
}

// 由UITabBarDelegate定义的方法，当用户选中某个标签项时激发该方法。
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(transferClassTabBarDidClick:)]) {
        [self.delegate transferClassTabBarDidClick:item];
    }
}

@end
