//
//  AdvertisementView.h
//  VKToken
//
//  Created by vankiachain on 2018/6/7.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdvertisementViewDelegate<NSObject>
- (void)goforwardDidClick;

@end


@interface AdvertisementView : UIView
@property(nonatomic, weak) id<AdvertisementViewDelegate> delegate;

@end
