//
//  BPCandidateService.h
//  VKToken
//
//  Created by vankiachain on 2018/6/9.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseService.h"
#import "GetBPCandidateListRequest.h"

@interface BPCandidateService : BaseService

@property(nonatomic , strong) GetBPCandidateListRequest *getBPCandidateListRequest;
- (void)buildNextPageDataSource:(CompleteBlock)complete;


@end
