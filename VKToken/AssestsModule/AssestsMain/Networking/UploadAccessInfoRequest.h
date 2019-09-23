//
//  GetWalletAccountsRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/1/31.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"


@interface UploadAccessInfoRequest : BaseNetworkRequest
@property(nonatomic, strong) NSString *uid;
@property(nonatomic, strong) NSString *os;
@property(nonatomic, strong) NSString *did;
@end
