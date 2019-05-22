//
//  RamManageViewController.h
//  VKToken
//
//  Created by vankiachain on 2018/10/24.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountResult.h"
#import "VKTResourceResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface RamManageViewController : BaseViewController
@property (nonatomic , retain) UINavigationController *navigationController;

@property(nonatomic , strong) AccountResult *accountResult;

@property(nonatomic , strong) VKTResourceResult *vktResourceResult;
@end

NS_ASSUME_NONNULL_END
