//
//  AssestsMainAddAccountView.h
//  VKToken
//
//  Created by vankiachain on 2018/11/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AssestsMainAddAccountViewDelegate <NSObject>

- (void)importAccount;
- (void)payRegist;
- (void)vipRegist;
- (void)freeCreateAccount;

@end

@interface AssestsMainAddAccountView : UIView

@property(nonatomic, weak) id<AssestsMainAddAccountViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
