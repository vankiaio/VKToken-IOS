//
//  UpdateUserNameRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/1/26.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateUserNameRequest : BaseNetworkRequest
@property(nonatomic, strong) NSString *userName;
@end
