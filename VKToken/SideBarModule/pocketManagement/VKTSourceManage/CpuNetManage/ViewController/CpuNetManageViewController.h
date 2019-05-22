//
//  CpuNetManageViewController.h
//  VKToken
//
//  Created by vankiachain on 2018/10/24.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseViewController.h"
#import "VKTResourceResult.h"
#import "VKTResource.h"
#import "VKTResourceCellModel.h"
#import "AccountResult.h"
#import "Account.h"


NS_ASSUME_NONNULL_BEGIN

@interface CpuNetManageViewController : BaseViewController
@property (nonatomic , retain) UINavigationController *navigationController;
@property(nonatomic , strong) AccountResult *accountResult;

@property(nonatomic , strong) VKTResourceResult *vktResourceResult;
@end

NS_ASSUME_NONNULL_END
