//
//  Get_account_assetsRequest.m
//  VKToken
//
//  Created by vankiachain on 2018/10/20.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "Get_account_assetsRequest.h"

@implementation Get_account_assetsRequest

-(NSString *)requestUrlPath{
    return @"/get_account_assets";
}

-(id)parameters{
    
    return VALIDATE_ARRAY(self.accountInfoArr);
}
@end
