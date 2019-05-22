//
//  AssestsShareDetailView.h
//  VKToken
//
//  Created by vankiachain on 16/04/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssestsShareDetailView : BaseView
@property (weak, nonatomic) IBOutlet UILabel *referencePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceChangeIn24hLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMarketCapitalizationLabel;

@end
