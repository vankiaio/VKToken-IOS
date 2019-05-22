
//
//  QuestionListService.h
//  VKToken
//
//  Created by vankiachain on 2018/2/3.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "GetQuestionListRequest.h"


@interface QuestionListService : BaseService

@property(nonatomic, strong) GetQuestionListRequest *getQuestionListRequest;
- (void)buildNextPageDataSource:(CompleteBlock)complete;
@end
