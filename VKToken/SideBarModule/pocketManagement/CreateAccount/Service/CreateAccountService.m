//
//  CreateAccountService.m
//  VKToken
//
//  Created by vankiachain on 2018/1/19.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "CreateAccountService.h"


@implementation CreateAccountService

- (CreateAccountRequest *)createAccountRequest{
    if (!_createAccountRequest) {
        _createAccountRequest = [[CreateAccountRequest alloc] init];
    }
    return _createAccountRequest;
}

- (BackupVktAccountRequest *)backupVktAccountRequest{
    if (!_backupVktAccountRequest) {
        _backupVktAccountRequest = [[BackupVktAccountRequest alloc] init];
    }
    return _backupVktAccountRequest;
}

- (CreateVKTAccountRequest *)createVKTAccountRequest{
    if (!_createVKTAccountRequest) {
        _createVKTAccountRequest = [[CreateVKTAccountRequest alloc] init];
    }
    return _createVKTAccountRequest;
}
- (void)createAccount:(CompleteBlock)complete{
    [self.createAccountRequest setShowActivityIndicator:YES];
    [self.createAccountRequest postDataSuccess:^(id DAO, id data) {
        complete(data , YES);
    } failure:^(id DAO, NSError *error) {
        NSLog(@"responseERROR:%@", [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:NSJSONReadingMutableContainers error:nil]);
    }];
}


/**
 备份账号到服务器
 */
- (void)backupAccount:(CompleteBlock)complete{
    
    [self.backupVktAccountRequest postDataSuccess:^(id DAO, id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            complete(data , YES);
        }
    } failure:^(id DAO, NSError *error) {
        complete(nil, NO);
    }];
    
}

- (void)createVKTAccount:(CompleteBlock)complete{
    [self.createVKTAccountRequest postDataSuccess:^(id DAO, id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            complete(data , YES);
        }
    } failure:^(id DAO, NSError *error) {
        complete(nil, NO);
    }];
}

@end
