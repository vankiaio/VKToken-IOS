//
//  VKTMappingResult.h
//  VKToken
//
//  Created by vankiachain on 2018/6/13.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKTMappingResult : NSObject
@property(nonatomic, strong) NSNumber *code;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) NSArray *account_names;

@end
