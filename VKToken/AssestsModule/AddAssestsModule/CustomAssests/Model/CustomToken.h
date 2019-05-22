//
//  CustomToken.h
//  VKToken
//
//  Created by vankiachain on 2018/7/20.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomToken : NSObject

/**
 RecommandToken id
 */
@property(nonatomic, copy) NSString *recommandToken_ID;

/**
 token 名字
 */
@property(nonatomic, copy) NSString *assetName;

/**
 合约名字
 */
@property(nonatomic, copy) NSString *contractName;

/**
 小图标
 */
@property(nonatomic, copy) NSString *iconUrl;

/**
 大图标
 */
@property(nonatomic, copy) NSString *iconUrlHd;




@end
