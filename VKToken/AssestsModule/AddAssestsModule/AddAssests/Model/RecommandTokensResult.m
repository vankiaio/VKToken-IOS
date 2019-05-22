//
//  RecommandTokensResult.m
//  VKToken
//
//  Created by vankiachain on 2018/7/19.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "RecommandTokensResult.h"

@implementation RecommandTokensResult
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"assetCategoryList" : @"RecommandToken",
             @"followAssetIds" : @"NSString"
              };
}
@end
