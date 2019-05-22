//
//  GetTransactionByIdRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/9/26.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "GetTransactionByIdRequest.h"

@implementation GetTransactionByIdRequest

-(NSString *)requestUrlPath{
    return [NSString stringWithFormat:@"%@/VX/GetTransactionById/%@", REQUEST_HISTORY_HTTP, self.transactionId];
    
}


@end
