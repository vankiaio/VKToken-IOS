//
//  GetWalletAccountsRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/1/31.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "UploadAccessInfoRequest.h"

@implementation UploadAccessInfoRequest

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/user/upload_access_info", REQUEST_PERSONAL_BASEURL ];
}

-(id)parameters{
    return @{@"uid" : VALIDATE_STRING(self.uid),
             @"os" : VALIDATE_STRING(self.os),
             @"did" : VALIDATE_STRING(self.did)
             };
}
@end
