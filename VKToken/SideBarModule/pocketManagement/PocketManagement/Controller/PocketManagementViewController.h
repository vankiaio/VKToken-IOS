//
//  PocketManagementViewController.h
//  VKToken
//
//  Created by vankiachain on 2017/12/11.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PocketManagementService.h"

@protocol PocketManagementViewControllerDelegate<NSObject>
- (void)changeAccountCellDidClick:(NSString *)name;
@end

@interface PocketManagementViewController : BaseViewController
@property(nonatomic, weak) id<PocketManagementViewControllerDelegate> delegate;
@property(nonatomic, strong) PocketManagementService *mainService;
@end
