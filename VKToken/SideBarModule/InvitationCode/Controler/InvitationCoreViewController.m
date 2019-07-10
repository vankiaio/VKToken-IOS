//
//  InvitationCoreViewController.m
//  VKToken
//
//  Created by 李轶 on 2019/7/9.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InvitationCoreViewController.h"
#import "InvitationCodeHeaderView.h"

@interface InvitationCoreViewController ()<UIGestureRecognizerDelegate , NavigationViewDelegate, InvitationCodeHeaderViewDelegate, UITextFieldDelegate>
@property(nonatomic, strong) NavigationView *navView;
@property(nonatomic, strong) InvitationCodeHeaderView *headerView;
@property(nonatomic, strong) NSString *currentAssestsType;
@end

@implementation InvitationCoreViewController

- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_navi_back" title:NSLocalizedString(@"邀请码", nil) rightBtnTitleName:NSLocalizedString(@"", nil) delegate:self];
        _navView.leftBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_navi_back"], UIControlStateNormal);
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
        layer.colors = @[(__bridge id)[UIColor colorWithRed:1/255.0 green:167/255.0 blue:173/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:30/255.0 green:167/255.0 blue:173/255.0 alpha:1.0].CGColor];
        layer.locations = @[@(0),@(1.0f)];
        [_navView.layer addSublayer:layer];
        [_navView addSubview: _navView.leftBtn];
        [_navView addSubview: _navView.titleLabel];
        _navView.titleLabel.textColor = [UIColor whiteColor];
    }
    return _navView;
}

- (InvitationCodeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"InvitationCodeHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 667);
    }
    return _headerView;
}

- (void)requestDownloadURL{
//    self.get_token_info_service.get_token_info_request.accountName = CURRENT_ACCOUNT_NAME;
//    WS(weakSelf);
//    [self.get_token_info_service get_token_info:^(id service, BOOL isSuccess) {
//        if (isSuccess) {
//
//        }
//    }];
    //钱包二维码
    NSString *QRCodeJsonStr = @"https://ttmcmobiledev.github.io/download/ttmc/ios-en.html?isForeign=0";
    self.headerView.shareInvitationQRCodeImg.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:QRCodeJsonStr logoImageName:@"logo_bg_blue" logoScaleToSuperView:0.2];
}

// 隐藏自带的导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestDownloadURL];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
}

// navigationViewDelegate
- (void)leftBtnDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
@end
