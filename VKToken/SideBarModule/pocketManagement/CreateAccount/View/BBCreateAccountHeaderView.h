//
//  BBCreateAccountHeaderView.h
//  VKToken
//
//  Created by vankiachain on 2018/5/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BBCreateAccountHeaderViewDelegate<NSObject>
- (void)createAccountUseVKTPrivateKey;
@end


@interface BBCreateAccountHeaderView : UIView
@property(nonatomic, weak) id<BBCreateAccountHeaderViewDelegate> delegate;

@end
