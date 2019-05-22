//
//  BPCandidateListViewController.h
//  VKToken
//
//  Created by vankiachain on 2018/6/8.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"
#import "MyVoteInfoResult.h"

@interface BPCandidateListViewController : BaseViewController
@property(nonatomic , strong) Account *model;
@property(nonatomic , strong) MyVoteInfoResult *myVoteInfoResult;
@end
