//
//  VktPrivateKey.h
//  wif_test
//
//  Created by vankiachain on 2018/3/14.
//  Copyright © 2018年 宋赓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VktPrivateKey : NSObject
- (instancetype)initVktPrivateKey;
@property(nonatomic, strong) NSString *vktPrivateKey;

@property(nonatomic, strong) NSString *vktPublicKey;


@end
