//
//  PersonalSettingService.m
//  VKToken
//
//  Created by vankiachain on 2018/1/26.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "PersonalSettingService.h"

@implementation PersonalSettingService

- (UploadWalletAvatarImageRequest *)uploadWalletAvatarImageRequest{
    if (!_uploadWalletAvatarImageRequest) {
        _uploadWalletAvatarImageRequest = [[UploadWalletAvatarImageRequest alloc] init];
    }
    return _uploadWalletAvatarImageRequest;
}


- (UpdateUserNameRequest *)updateUserNameRequest{
    if (!_updateUserNameRequest) {
        _updateUserNameRequest = [[UpdateUserNameRequest alloc] init];
    }
    return _updateUserNameRequest;
}


@end
