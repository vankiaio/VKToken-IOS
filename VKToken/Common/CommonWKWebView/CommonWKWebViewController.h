//
//  CommonWKWebViewController.h
//  VKToken
//
//  Created by vankiachain on 2018/7/6.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>


@interface CommonWKWebViewController : UIViewController
@property(nonatomic, copy) NSString *urlStr;
@property(nonatomic , copy) NSString *parameterStr;
@end
