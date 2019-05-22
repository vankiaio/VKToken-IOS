//
//  BackupVKTAccountService.h
//  VKToken
//
//  Created by vankiachain on 2018/6/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "BackupVktAccountRequest.h"

@interface BackupVKTAccountService : BaseService
@property(nonatomic, strong) BackupVktAccountRequest *backupVktAccountRequest;

/**
 备份账号到服务器
 */
- (void)backupAccount:(CompleteBlock)complete;

@end
