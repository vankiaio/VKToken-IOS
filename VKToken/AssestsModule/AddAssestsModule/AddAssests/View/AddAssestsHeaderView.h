//
//  AddAssestsHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2018/7/17.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseView.h"

@protocol AddAssestsHeaderViewDelegate<NSObject>

- (void)customAssestsBtnDidClick;

@end


@interface AddAssestsHeaderView : BaseView
@property(nonatomic, weak) id<AddAssestsHeaderViewDelegate> delegate;

@end
