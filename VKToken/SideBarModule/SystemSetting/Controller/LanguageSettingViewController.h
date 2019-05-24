//
//  LanguageSettingViewController.h
//  VKToken
//
//  Created by vankiachain on 2018/6/8.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseViewController.h"

/**
 从那个模式下跳转过来
 */
typedef NS_ENUM(NSInteger, LanguageSettingViewControllerFromMode) {
    LanguageSettingViewControllerFromLoginPage,
    LanguageSettingViewControllerFromOtherPage
};

@interface LanguageSettingViewController : BaseViewController

@property(nonatomic , assign) LanguageSettingViewControllerFromMode languageSettingViewControllerFromMode;

@end
