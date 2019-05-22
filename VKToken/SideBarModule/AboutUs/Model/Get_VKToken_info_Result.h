//
//  Get_VKToken_info_Result.h
//  VKToken
//
//  Created by vankiachain on 2018/11/1.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface Get_VKToken_info_Result : BaseResult

@property(nonatomic , copy) NSString *weChatOfficialAccount;

@property(nonatomic , copy) NSString *weChat;

@property(nonatomic , copy) NSString *officialWebsite;


@property(nonatomic , copy) NSString *companyProfile;
@end


NS_ASSUME_NONNULL_END
