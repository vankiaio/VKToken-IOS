//
//  GetInvitationCodeService.m
//  VKToken
//
//  Created by vankiachain on 2019/7/31.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import "GetInvitationCodeService.h"
#import "VKToken-swift.h"

@implementation GetInvitationCodeService

- (InvitationCodeRequest *)invitationCodeRequest{
    if (!_invitationCodeRequest) {
        _invitationCodeRequest = [[InvitationCodeRequest alloc] init];
    }
    return _invitationCodeRequest;
}

- (void)getInviteCode:(CompleteBlock)complete{
    [self.invitationCodeRequest postOuterDataSuccess:^(id DAO, id data) {
        if ([data isKindOfClass:[NSDictionary class]]) {
            complete(data , YES);
        }
    } failure:^(id DAO, NSError *error) {
        complete(nil, NO);
    }];
}

@end
