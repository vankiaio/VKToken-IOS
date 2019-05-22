//
//  RedPacketRecordResult.h
//  VKToken
//
//  Created by vankiachain on 20/04/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 红包记录 list
 */
@interface RedPacketRecordResult : NSObject
@property(nonatomic, strong) NSString *msg;
@property(nonatomic, strong) NSNumber *code;
@property(nonatomic, strong) NSMutableArray *data;
@end
