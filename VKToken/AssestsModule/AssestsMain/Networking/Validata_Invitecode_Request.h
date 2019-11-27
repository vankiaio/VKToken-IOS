//
//  Validata_Invitecode.h
//  VKToken
//
//  Created by 李轶 on 2019/11/27.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#ifndef Validata_Invitecode_h
#define Validata_Invitecode_h
/**
 区块公共 / 检验邀请码
 */
@interface Validata_Invitecode_Request : BaseNetworkRequest
/**
 邀请码
 */
@property(nonatomic, strong) NSString *InvitationCode;

@end
#endif /* Validata_Invitecode_h */
