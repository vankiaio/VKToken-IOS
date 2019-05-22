//
//  ScrollMenuView.h
//  VKToken
//
//  Created by vankiachain on 2018/7/5.
//  Copyright © 2018 vankiachain. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Assest.h"
#import "BaseSlimLineView.h"

@protocol ScrollMenuViewDelegate<NSObject>
- (void)menuScrollViewItemBtnDidClick:(UIButton *)sender;
@end

@interface ScrollMenuView : UIView

@property(nonatomic, weak) id<ScrollMenuViewDelegate> delegate;
- (void)updateViewWithOptionModelArray:(NSArray<OptionModel *> *)modelArray;
@property(nonatomic , strong) BaseSlimLineView *bottomLineView;
@end
