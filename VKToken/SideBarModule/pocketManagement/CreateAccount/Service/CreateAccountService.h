//
//  CreateAccountService.h
//  VKToken
//
//  Created by vankiachain on 2018/1/19.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "CreateAccountRequest.h"
#import "BackupVktAccountRequest.h"
#import "CreateVKTAccountRequest.h"

@interface CreateAccountService : BaseService
@property(nonatomic, strong) CreateAccountRequest *createAccountRequest;
@property(nonatomic, strong) BackupVktAccountRequest *backupVktAccountRequest;
@property(nonatomic , strong) CreateVKTAccountRequest *createVKTAccountRequest;

- (void)createAccount:(CompleteBlock)complete;


/**
 备份账号到服务器
 */
- (void)backupAccount:(CompleteBlock)complete;

- (void)createVKTAccount:(CompleteBlock)complete;


@end
