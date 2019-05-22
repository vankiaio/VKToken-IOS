//
//  CountryCodeAreaViewController.h
//  VKToken
//
//  Created by vankiachain on 2018/7/6.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseViewController.h"
#import "AreaCodeModel.h"

@protocol CountryCodeAreaViewControllerDelegate<NSObject>
- (void)countryCodeAreaCellDidSelect:(AreaCodeModel *)model;
@end


@interface CountryCodeAreaViewController : BaseViewController
@property(nonatomic, weak) id<CountryCodeAreaViewControllerDelegate> delegate;

@end
