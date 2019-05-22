//
//  DAppDetailViewController.h
//  VKToken
//
//  Created by vankiachain on 09/05/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DappModel.h"
#import "DappChangeAccountOnNavigationRightView.h"


@interface DAppDetailViewController : BaseViewController
@property(nonatomic , strong) DappModel *model;

@property(nonatomic, strong) NSString *choosedAccountName;


@property (nonatomic , strong) UIButton *closeItem;
@property(nonatomic , strong) DappChangeAccountOnNavigationRightView *dappChangeAccountOnNavigationRightView;
@end
