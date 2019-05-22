//
//  VKTResourceResult.m
//  VKToken
//
//  Created by vankiachain on 2018/6/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "VKTResourceResult.h"

@implementation VKTResourceResult

- (VKTResource *)data{
    if (!_data) {
        _data = [[VKTResource alloc] init];
    }
    return _data;
}

@end
