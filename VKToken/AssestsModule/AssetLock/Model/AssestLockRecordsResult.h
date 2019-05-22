//
//  AssestLockRecordsResult.h
//  VKToken
//
//  Created by vankiachain on 2018/2/7.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AssestLockRecordsResult : NSObject
@property(nonatomic, strong) NSString *msg;


@property(nonatomic, strong) NSNumber *code;
@property(nonatomic, strong) NSMutableDictionary *data;

@end
