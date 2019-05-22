//
//  Get_recommend_dapp_result.m
//  VKToken
//
//  Created by vankiachain on 2018/11/1.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "Get_recommend_dapp_result.h"

@implementation Get_recommend_dapp_result
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"bannerDapps" : @"data.bannerDapps",
             @"introDapps" : @"data.introDapps",
             @"starDapps" : @"data.starDapps"             
             };
}

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"bannerDapps" : @"DappModel",
             @"introDapps" : @"DappModel",
             @"starDapps" : @"DappModel"
             };
}

@end
