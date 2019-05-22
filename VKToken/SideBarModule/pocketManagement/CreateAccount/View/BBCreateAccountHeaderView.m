//
//  BBCreateAccountHeaderView.m
//  VKToken
//
//  Created by vankiachain on 2018/5/21.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "BBCreateAccountHeaderView.h"

@implementation BBCreateAccountHeaderView

- (IBAction)createAccount:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(createAccountUseVKTPrivateKey)]) {
        [self.delegate createAccountUseVKTPrivateKey];
    }
}

@end
