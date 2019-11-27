//
//  FeedbackHeaderView.m
//  VKToken
//
//  Created by 李轶 on 2019/11/9.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FeedbackHeaderView.h"
#import "FeedbackViewController.h"
#import "SocialSharePanelView.h"
#import "SocialShareModel.h"
#import "GetInvitationCodeService.h"
#import "UIImage+ExFoundation.h"
#import "VKToken-swift.h"

@interface FeedbackViewController ()<UIGestureRecognizerDelegate , NavigationViewDelegate, UITextFieldDelegate>
@property(nonatomic, strong) NavigationView *navView;
@property(nonatomic, strong) FeedbackHeaderView *headerView;
@property(nonatomic, strong) NSString *currentAssestsType;
@property(nonatomic , strong) UIView *shareBaseView;
@property(nonatomic , strong) SocialSharePanelView *socialSharePanelView;
@property(nonatomic , strong) NSArray *platformNameArr;
@end

@implementation FeedbackViewController

- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_navi_back" title:NSLocalizedString(@"意见反馈", nil) rightBtnImgName:@"icon_share" delegate:self];
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

- (FeedbackHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"FeedbackHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _headerView;
}

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

- (NSArray *)platformNameArr{
    if (!_platformNameArr) {
        _platformNameArr = @[@"wechat_friends",@"wechat_moments",@"save_screenshot", @"qq_friends", @"qq_Zone"];
    }
    return _platformNameArr;
}

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
}

// navigationViewDelegate
- (void)leftBtnDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnDidClick{
    [self.view addSubview:self.shareBaseView];
    self.shareBaseView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).heightIs(SCREEN_HEIGHT);
}

// SocialSharePanelViewDelegate
- (void)SocialSharePanelViewDidTap:(UITapGestureRecognizer *)sender{
    NSString *platformName = self.platformNameArr[sender.view.tag-1000];
    ShareModel *model = [[ShareModel alloc] init];
    model.imageName = @"vkt_avatar";
    
    model.title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"邀请函", nil)];

    model.detailDescription = [NSString stringWithFormat:@"%@%@\n%@\n", NSLocalizedString(@"您的专属邀请码：", nil),@"5V213", NSLocalizedString(@"使用邀请码创建账号获取VKT奖励", nil)];

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
    [self.shareBaseView removeFromSuperview];
}

- (void)cancelShareAssestsDetail{
    [self.shareBaseView removeFromSuperview];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
@end
