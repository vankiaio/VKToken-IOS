//
//  Question.m
//  VKToken
//
//  Created by vankiachain on 2018/2/5.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "Question.h"

@implementation Question
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"question_id" : @"id"
             };
}
@end
