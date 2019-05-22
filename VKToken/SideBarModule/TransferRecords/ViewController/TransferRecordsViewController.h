//
//  TransferRecordsViewController.h
//  VKToken
//
//  Created by vankiachain on 2018/8/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BaseViewController.h"
#import "TokenInfo.h"

@interface TransferRecordsViewController : BaseViewController

@property(nonatomic , copy) NSString *from;

@property(nonatomic , copy) NSString *to;

@property(nonatomic , strong) TokenInfo *currentToken;

@property(nonatomic , strong) NSMutableArray *get_token_info_service_data_array;

@end
