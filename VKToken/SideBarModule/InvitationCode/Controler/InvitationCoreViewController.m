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
#import "SocialSharePanelView.h"
#import "SocialShareModel.h"
#import "GetInvitationCodeService.h"
#import "UIImage+ExFoundation.h"
#import "VKToken-swift.h"

@interface InvitationCoreViewController ()<UIGestureRecognizerDelegate , NavigationViewDelegate, InvitationCodeHeaderViewDelegate, UITextFieldDelegate>
@property(nonatomic, strong) NavigationView *navView;
@property(nonatomic, strong) InvitationCodeHeaderView *headerView;
@property(nonatomic, strong) NSString *currentAssestsType;
//@property(nonatomic , strong) UIView *shareBaseView;
//@property(nonatomic , strong) SocialSharePanelView *socialSharePanelView;
@property(nonatomic , strong) NSArray *platformNameArr;
@property(nonatomic, strong) GetInvitationCodeService *mainService;
@property(nonatomic, strong) NSString *qRCodeJsonURL;
@end

@implementation InvitationCoreViewController

- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_navi_back" title:NSLocalizedString(@"邀请码", nil) rightBtnImgName:@"icon_share" delegate:self];
        _navView.leftBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_navi_back"], UIControlStateNormal);
        _navView.rightBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_share"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_share"], UIControlStateNormal);
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT);
        layer.colors = @[(__bridge id)[UIColor colorWithRed:1/255.0 green:167/255.0 blue:173/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:30/255.0 green:167/255.0 blue:173/255.0 alpha:1.0].CGColor];
        layer.locations = @[@(0),@(1.0f)];
        [_navView.layer addSublayer:layer];
        [_navView addSubview: _navView.leftBtn];
        [_navView addSubview: _navView.rightBtn];
        [_navView addSubview: _navView.titleLabel];
        _navView.titleLabel.textColor = [UIColor whiteColor];
    }
    return _navView;
}

- (InvitationCodeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"InvitationCodeHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _headerView;
}

- (GetInvitationCodeService *)mainService{
    if (!_mainService) {
        _mainService = [[GetInvitationCodeService alloc] init];
    }
    return _mainService;
}

#if 0
- (SocialSharePanelView *)socialSharePanelView{
    if (!_socialSharePanelView) {
        _socialSharePanelView = [[SocialSharePanelView alloc] init];
        _socialSharePanelView.backgroundColor = HEXCOLOR(0xF7F7F7);
        _socialSharePanelView.delegate = self;
        NSMutableArray *modelArr = [NSMutableArray array];
        NSArray *titleArr = @[NSLocalizedString(@"微信好友", nil),NSLocalizedString(@"朋友圈", nil),NSLocalizedString(@"截图保存", nil)];//, NSLocalizedString(@"QQ好友", nil), NSLocalizedString(@"QQ空间", nil)
        for (int i = 0; i < titleArr.count; i++) {
            SocialShareModel *model = [[SocialShareModel alloc] init];
            model.platformName = titleArr[i];
            model.platformImage = self.platformNameArr[i];
            [modelArr addObject:model];
        }
        self.socialSharePanelView.labelTopSpace = 33;
        [_socialSharePanelView updateViewWithArray:modelArr];
    }
    return _socialSharePanelView;
}
#endif

- (NSArray *)platformNameArr{
    if (!_platformNameArr) {
        _platformNameArr = @[@"wechat_friends",@"wechat_moments",@"save_screenshot", @"qq_friends", @"qq_Zone"];
    }
    return _platformNameArr;
}

#if 0
- (UIView *)shareBaseView{
    if (!_shareBaseView) {
        _shareBaseView = [[UIView alloc] init];
        _shareBaseView.userInteractionEnabled = YES;
        _shareBaseView.backgroundColor = [UIColor clearColor];

        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = [UIColor blackColor];
        topView.alpha = 0.5;
        topView.userInteractionEnabled = YES;
        [_shareBaseView addSubview:topView];
        topView.sd_layout.leftSpaceToView(_shareBaseView, 0).rightSpaceToView(_shareBaseView, 0).topSpaceToView(_shareBaseView, 0).heightIs(SCREEN_HEIGHT - 47 - 116);

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [topView addGestureRecognizer:tap];

        UIButton *cancleBtn = [[UIButton alloc] init];
        [cancleBtn setTitle:NSLocalizedString(@"取消", nil)forState:(UIControlStateNormal)];
        [cancleBtn setBackgroundColor:HEXCOLOR(0xF7F7F7)];
        [cancleBtn setTitleColor:HEXCOLOR(0x2A2A2A) forState:(UIControlStateNormal)];
        [cancleBtn addTarget:self action:@selector(cancelShareAssestsDetail) forControlEvents:(UIControlEventTouchUpInside)];
        [_shareBaseView addSubview:cancleBtn];
        cancleBtn.sd_layout.leftSpaceToView(_shareBaseView ,0 ).rightSpaceToView(_shareBaseView, 0).bottomSpaceToView(_shareBaseView, 0).heightIs(47);

        [_shareBaseView addSubview:self.socialSharePanelView];
        _socialSharePanelView.sd_layout.leftSpaceToView(_shareBaseView, 0).rightSpaceToView(_shareBaseView, 0).bottomSpaceToView(cancleBtn, 0).heightIs(116);

    }
    return _shareBaseView;
}
#endif

- (void)requestDownloadURL{
    //钱包二维码
    NSString *QRCodeJsonStr = self.qRCodeJsonURL;
    self.headerView.shareInvitationQRCodeImg.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:QRCodeJsonStr logoImageName:@"logo_bg_blue" logoScaleToSuperView:0.2];
}

// 隐藏自带的导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
    [self genInviteCode];
}

// navigationViewDelegate
- (void)leftBtnDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnDidClick{
#if 0
    [self.view addSubview:self.shareBaseView];
    self.shareBaseView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).heightIs(SCREEN_HEIGHT);
#endif
    
    // 分享的title
    NSString *textToShare = NSLocalizedString(@"分享并使用邀请码创建账号获取VKT奖励", nil);
    // 分享的图片
    //    1.获取一个截图图片
    UIImage *imageToShare = [ UIImage convertViewToImage:self.view];
    // 分享的链接地址
    NSURL *urlToShare = [NSURL URLWithString:@"https://vktokendev.github.io/download/vktoken/index.html"];
    // 顺序可以混乱，系统会自动识别类型
    NSArray *activityItems = @[textToShare,imageToShare];
    // 调起系统分享视图
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[]];
    // 设置忽略分享App的属性
    //    vc.excludedActivityTypes = @[UIActivityTypePostToVimeo];
    // 分享结果后的回调Block
    vc.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        NSLog(@"%@", activityType);
        if (completed) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"分享成功",nil) message:NSLocalizedString(@"分享成功",nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"取消分享",nil) message:NSLocalizedString(@"取消分享",nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    };
    [self presentViewController:vc animated:YES completion:nil];
}

/**
 生成邀请码
 */
- (void)genInviteCode{
    WS(weakSelf);

    weakSelf.mainService.invitationCodeRequest.account_id = CURRENT_ACCOUNT_NAME;
    // 生成邀请码
    
    [weakSelf.mainService getInviteCode:^(id service, BOOL isSuccess) {
        
        if (isSuccess) {
            NSNumber *code = service[@"code"];
            if ([code isEqualToNumber:@0]) {
                self.headerView.invitationCodeLabel.text = service[@"data"][@"code"];
                self.qRCodeJsonURL = service[@"data"][@"qrcodeurl"];
                [self requestDownloadURL];
            }else{
                [TOASTVIEW showWithText:VALIDATE_STRING(service[@"message"])];
            }
        }
    }];
}

#if 0
// SocialSharePanelViewDelegate
- (void)SocialSharePanelViewDidTap:(UITapGestureRecognizer *)sender{
    NSString *platformName = self.platformNameArr[sender.view.tag-1000];
    ShareModel *model = [[ShareModel alloc] init];
    model.imageName = @"vkt_avatar";
    
    model.title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"邀请函", nil)];

    model.detailDescription = [NSString stringWithFormat:@"%@%@\n%@\n", NSLocalizedString(@"您的专属邀请码：", nil),@"5V213", NSLocalizedString(@"分享并使用邀请码创建账号获取VKT奖励", nil)];
    model.webPageUrl = self.qRCodeJsonURL;
    NSLog(@"%@", platformName);
    if ([platformName isEqualToString:@"wechat_friends"]) {
        [[SocialManager socialManager] wechatShareToScene:0 withShareModel:model];
    }else if ([platformName isEqualToString:@"wechat_moments"]){
        [[SocialManager socialManager] wechatShareToScene:1 withShareModel:model];
    }else if ([platformName isEqualToString:@"qq_friends"]){
        [[SocialManager socialManager] qqShareToScene:0 withShareModel:model];
    }else if ([platformName isEqualToString:@"qq_Zone"]){
        [[SocialManager socialManager] qqShareToScene:1 withShareModel:model];
    }else if ([platformName isEqualToString:@"save_screenshot"]){
        //  hiden sharebar
        [self dismiss];
        //    1.获取一个截图图片
        UIImage *newImage = [ UIImage convertViewToImage:self.view];
        //    2.写入相册
        UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
    }
}
#endif

#pragma mark 用来监听图片保存到相册的状况

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [TOASTVIEW showWithText:NSLocalizedString(@"保存失败", nil)];
    }else{
        [TOASTVIEW showWithText:NSLocalizedString(@"保存成功", nil)];
    }
    
    NSLog(@"%@",contextInfo);
    
}

- (void)dismiss{
//    [self.shareBaseView removeFromSuperview];
}

- (void)cancelShareAssestsDetail{
//    [self.shareBaseView removeFromSuperview];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
@end
