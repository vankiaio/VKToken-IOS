
//
//  BackupVKTAccountService.m
//  VKToken
//
//  Created by vankiachain on 2018/6/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BackupVKTAccountService.h"
#import "BackupVktAccountRequest.h"

@implementation BackupVKTAccountService

- (BackupVktAccountRequest *)backupVktAccountRequest{
    if (!_backupVktAccountRequest) {
        _backupVktAccountRequest = [[BackupVktAccountRequest alloc] init];
    }
    return _backupVktAccountRequest;
}
- (void)backupAccount:(CompleteBlock)complete{
    
    [self.backupVktAccountRequest postDataSuccess:^(id DAO, id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            complete(data , YES);
        }
    } failure:^(id DAO, NSError *error) {
        complete(nil, NO);
    }];
    
}

@end
