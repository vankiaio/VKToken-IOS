//
//  AuthRedPacketResult.h
//  VKToken
//
//  Created by vankiachain on 2018/7/2.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AuthRedPacket;
@interface AuthRedPacketResult : NSObject

@property(nonatomic, strong) NSNumber *code;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, strong) AuthRedPacket *data;


@end
