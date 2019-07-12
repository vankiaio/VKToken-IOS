//
//  RecieveViewController.h
//  VKToken
//
//  Created by vankiachain on 2017/12/5.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TransferModel.h"
#import "TokenInfo.h"

@interface RecieveViewController : BaseViewController
@property(nonatomic, strong) TransferModel *transferModel;
@property(nonatomic , strong) NSMutableArray *get_token_info_service_data_array;
@end
