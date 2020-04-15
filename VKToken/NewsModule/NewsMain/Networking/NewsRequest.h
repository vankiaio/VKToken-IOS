//
//  NewsRequest.h
//  VKToken
//
//  Created by vankiachain on 2017/12/27.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "BaseHttps2NetworkRequest.h"

@interface NewsRequest : BaseHttps2NetworkRequest

/**
 一页显示的记录数
 */
@property(nonatomic, strong) NSNumber *size;

/**
 起始位置
 */
@property(nonatomic, strong) NSNumber *offset;

/**
 资产类型
 */
@property(nonatomic, strong) NSNumber *assetCategoryId;


/**
 新闻分类，1表示banner新闻，2表示列表新闻，3待定
 */
@property(nonatomic, strong) NSNumber *scope;


@end
