//
//  AssestsCollectionFooterView.h
//  VKToken
//
//  Created by vankiachain on 2018/10/20.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AssestsCollectionFooterViewDelegate <NSObject>

- (void)assestsCollectionFooterViewConfirmBtnDidClick;

@end

@interface AssestsCollectionFooterView : BaseView

@property(nonatomic, weak) id<AssestsCollectionFooterViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;

@end

NS_ASSUME_NONNULL_END
