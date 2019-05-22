//
//  LanguageSettingService.m
//  VKToken
//
//  Created by vankiachain on 2018/6/8.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "LanguageSettingService.h"

@implementation LanguageSettingService

-(void)buildDataSource:(CompleteBlock)complete{
    self.dataSourceArray = @[NSLocalizedString(@"中文", nil), @"English"];
    complete(self, YES);
}

@end
