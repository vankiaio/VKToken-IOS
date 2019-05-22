//
//  QRCodeModel.h
//  VKToken
//
//  Created by vankiachain on 2018/9/20.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCodeModel : NSObject

@property(nonatomic , copy) NSString *protocol;
@property(nonatomic , copy) NSString *type;
@property(nonatomic , copy) NSString *version;
@property(nonatomic , strong) id qr_details;

@end
