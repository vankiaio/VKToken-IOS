//
//  MyVoteInfo.h
//  VKToken
//
//  Created by vankiachain on 2018/6/12.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyVoteInfo : NSObject
@property(nonatomic , copy) NSString *owner;
@property(nonatomic , copy) NSString *staked;
@property(nonatomic , copy) NSString *last_vote_weight;
@property(nonatomic , copy) NSString *is_proxy;
@property(nonatomic , copy) NSString *proxy;
@property(nonatomic , strong) NSArray *producers;
@end
