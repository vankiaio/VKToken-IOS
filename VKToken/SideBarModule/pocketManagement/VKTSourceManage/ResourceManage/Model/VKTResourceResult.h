//
//  VKTResourceResult.h
//  VKToken
//
//  Created by vankiachain on 2018/6/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VKTResource.h"

@interface VKTResourceResult : NSObject
@property(nonatomic, strong) NSNumber *code;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) VKTResource *data;
@end
