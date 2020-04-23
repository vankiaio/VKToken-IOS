//
//  MessageCenter.h
//  VKToken
//
//  Created by vankiachain on 2018/1/29.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageCenter : NSObject

/**
 标题
 */
@property(nonatomic, strong) NSString *id;

/**
 标题
 */
@property(nonatomic, strong) NSString *title;

/**
 简介
 */
@property(nonatomic, strong) NSString *content;
/**
 
 创建时间
 */
@property(nonatomic, strong) NSString *createTime;
/**
 
 更新时间
 */
@property(nonatomic, strong) NSString *updateTime;


@end
