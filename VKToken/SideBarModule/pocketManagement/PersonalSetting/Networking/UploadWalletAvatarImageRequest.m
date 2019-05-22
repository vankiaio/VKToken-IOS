//
//  UploadWalletAvatarImageRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/25.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "UploadWalletAvatarImageRequest.h"

@implementation UploadWalletAvatarImageRequest
-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/user/headImgUpload", REQUEST_PERSONAL_BASEURL];

}

-(id)parameters{
    return @{@"uid" : VALIDATE_STRING(CURRENT_WALLET_UID)};
}
@end
