//
//  ImportAccountsRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/8/22.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"

@interface ImportAccountsRequest : BaseNetworkRequest

@property(nonatomic, copy) NSString *uid;

@property(nonatomic, strong) NSArray *accountList;

@end
