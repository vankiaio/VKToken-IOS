//
//  AuthPasswordViewController.h
//  TokenBank
//
//  Created by MarcusWoo on 13/02/2018.
//  Copyright © 2018 MarcusWoo. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, kPasswordType) {
    kPasswordTypeSet = 0,
    kPasswordTypeReconfirm = 1,
    kPasswordTypeEnter = 2,
    kPasswordTypeCancel = 3
};

@interface AuthPasswordViewController : BaseViewController
@property (nonatomic, assign) kPasswordType pwdType;
@property (nonatomic, strong) NSString *prePassword;
@end
