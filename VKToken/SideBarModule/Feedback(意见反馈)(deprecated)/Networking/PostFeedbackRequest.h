//
//  PostFeedbackRequest.h
//  VKToken
//
//  Created by vankiachain on 2018/1/29.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"

@interface PostFeedbackRequest : BaseNetworkRequest
/**
 提交反馈的用户uid
 */
@property(nonatomic, strong) NSString *uid;

/**
 提交反馈的内容
 */
@property(nonatomic, strong) NSString *content;

@end
