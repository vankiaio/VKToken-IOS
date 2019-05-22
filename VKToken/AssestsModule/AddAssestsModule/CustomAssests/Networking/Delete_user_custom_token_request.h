//
//  Delete_user_custom_token_request.h
//  VKToken
//
//  Created by vankiachain on 2018/7/19.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseNetworkRequest.h"

@interface Delete_user_custom_token_request : BaseNetworkRequest
@property(nonatomic, copy) NSString *accountName;

@property(nonatomic, copy) NSString *recommandToken_ID;
@end
