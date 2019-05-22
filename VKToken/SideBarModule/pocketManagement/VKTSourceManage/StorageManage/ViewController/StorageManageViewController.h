//
//  StorageManageViewController.h
//  VKToken
//
//  Created by 师巍巍 on 21/06/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseViewController.h"
#import "VKTResourceResult.h"
#import "VKTResource.h"
#import "VKTResourceCellModel.h"
#import "AccountResult.h"

@interface StorageManageViewController : BaseViewController

@property (nonatomic , retain) UINavigationController *navigationController;
@property(nonatomic , strong) AccountResult *accountResult;

@end
