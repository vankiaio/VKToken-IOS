//
//  AddAssestsViewController.h
//  VKToken
//
//  Created by vankiachain on 2018/7/17.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseViewController.h"

@protocol AddAssestsViewControllerDelegate<NSObject>

- (void)addAssestsViewControllerbackButtonDidClick:(NSMutableArray *)ids;

@end


@interface AddAssestsViewController : BaseViewController
// 默认选择的账号
@property(nonatomic, copy) NSString *accountName;


@property(nonatomic, weak) id<AddAssestsViewControllerDelegate> delegate;

@end
