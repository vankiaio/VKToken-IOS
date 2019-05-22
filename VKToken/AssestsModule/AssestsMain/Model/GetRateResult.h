//
//  GetRateResult.h
//  VKToken
//
//  Created by vankiachain on 2018/3/22.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rate;
@interface GetRateResult : NSObject
@property(nonatomic, strong) NSNumber *code;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) Rate *data;
@end
