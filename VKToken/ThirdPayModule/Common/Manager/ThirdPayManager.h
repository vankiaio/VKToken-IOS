//
//  ThirdPayManager.h
//  VKToken
//
//  Created by vankiachain on 2018/7/31.
//  Copyright © 2018 vankiachain. All rights reserved.
//

typedef enum {
    kAlipay= 1,
    kWechatPay,
}ThirdPayType;


#import <Foundation/Foundation.h>
#import "WXApi.h"


@protocol ThirdPayManagerDelegate <NSObject>

@optional


@end

@interface ThirdPayManager : NSObject<ThirdPayManagerDelegate, WXApiDelegate>

@property (nonatomic, assign) id<ThirdPayManagerDelegate> delegate;

+ (instancetype)sharedManager;

@property(nonatomic, assign) ThirdPayType thirdPayType;

@end
