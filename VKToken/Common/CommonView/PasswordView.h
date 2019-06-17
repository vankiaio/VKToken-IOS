//
//  PasswordView.h
//  VKToken
//
//  Created by Lee on 2019/6/13.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#ifndef PasswordView_h
#define PasswordView_h

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    eEmptyPassword,
    eWeakPassword,
    eSosoPassword,
    eGoodPassword,
    eSafePassword,
} PasswordEnum;

@interface PasswordView : UIView

@property (nonatomic, assign) PasswordEnum strongType;

- (void)showPasswordViewEffectWith:(PasswordEnum)strongType;

@end

#endif /* PasswordView_h */
