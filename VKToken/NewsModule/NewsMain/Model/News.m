//
//  News.m
//  VKToken
//
//  Created by vankiachain on 2017/12/27.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "News.h"
#import "MJExtension.h"

@implementation News

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"news_id" : @"id"
             };
}

// NSCoding实现
MJExtensionCodingImplementation

@end
