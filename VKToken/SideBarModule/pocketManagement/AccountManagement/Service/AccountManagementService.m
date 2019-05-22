//
//  AccountManagementService.m
//  VKToken
//
//  Created by vankiachain on 2018/1/31.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "AccountManagementService.h"

@implementation AccountManagementService

- (void)buildDataSource:(CompleteBlock)complete{
    if (LEETHEME_CURRENTTHEME_IS_SOCAIL_MODE) {
        self.dataSourceArray = [NSMutableArray arrayWithObjects:NSLocalizedString(@"设为主账号", nil), NSLocalizedString(@"VKT资源管理", nil), NSLocalizedString(@"导出私钥", nil),  nil];//,NSLocalizedString(@"保护隐私", nil) , NSLocalizedString(@"VKT一键赎回", nil)
    }else if (LEETHEME_CURRENTTHEME_IS_BLACKBOX_MODE){
//        self.dataSourceArray = [NSMutableArray arrayWithObjects: NSLocalizedString(@"VKT资源管理", nil), NSLocalizedString(@"导出私钥", nil), nil];
        self.dataSourceArray = [NSMutableArray arrayWithObjects: NSLocalizedString(@"导出私钥", nil), nil];
    }
}
@end
