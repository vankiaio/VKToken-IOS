//
//  RamManageHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2018/10/24.
//  Copyright © 2018 vankiachain. All rights reserved.
//

typedef NS_ENUM(NSInteger, RamManageHeaderViewCurrentAction) {
    RamManageHeaderViewCurrentActionBuyRam ,         // BuyRam
    RamManageHeaderViewCurrentActionSellRam,        // SellRam
} ;


#import "BaseView.h"
#import "VKTResourceResult.h"

NS_ASSUME_NONNULL_BEGIN


@protocol RamManageHeaderViewDelegate<NSObject>
- (void)ramManageHeaderViewConfirmStakeBtnDidClick;
@end


@interface RamManageHeaderView : BaseView

@property(nonatomic , assign) RamManageHeaderViewCurrentAction ramManageHeaderViewCurrentAction;

@property (weak, nonatomic) IBOutlet BaseLabel1 *ramDetailLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *ramProgressView;
@property (weak, nonatomic) IBOutlet BaseLabel1 *priceChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPriceLanel;
@property (weak, nonatomic) IBOutlet UIImageView *indicateImageView;


@property (weak, nonatomic) IBOutlet UITextField *vktAmountTF;
@property (weak, nonatomic) IBOutlet UILabel *ramAmountUnitLabel;

@property (weak, nonatomic) IBOutlet BaseLabel1 *avalibleAmountLabel;



@property(nonatomic, weak) id<RamManageHeaderViewDelegate> delegate;


- (void)updateViewWithVKTResourceResult:(VKTResourceResult *)model;
@end

NS_ASSUME_NONNULL_END
