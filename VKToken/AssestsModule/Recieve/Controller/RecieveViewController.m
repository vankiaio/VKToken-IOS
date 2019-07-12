//
//  RecieveViewController.m
//  VKToken
//
//  Created by vankiachain on 2017/12/5.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "RecieveViewController.h"
#import "RecieveHeaderView.h"
#import "NavigationView.h"
#import "RecieveQRCodeView.h"
#import "Assest.h"
#import "SGQRCode.h"
#import "TransactionRecordsService.h"
#import "TransactionRecord.h"
#import "GetRateResult.h"
#import "Rate.h"
#import "TransferService.h"
#import "TokenInfo.h"
#import "Get_token_info_service.h"
#import "TransferRecordsViewController.h"
#import "AssestsShareDetailView.h"
#import "SocialSharePanelView.h"
#import "SocialShareModel.h"
#import "VKToken-swift.h"

@interface RecieveViewController ()<UIGestureRecognizerDelegate , NavigationViewDelegate, RecieveHeaderViewDelegate, UITextFieldDelegate>
@property(nonatomic, strong) NavigationView *navView;
@property(nonatomic, strong) RecieveHeaderView *headerView;
@property(nonatomic, strong) RecieveQRCodeView *recieveQRCodeView;
@property(nonatomic, strong) NSString *currentAssestsType;
@property(nonatomic, strong) TransactionRecordsService *transactionRecordsService;
@property(nonatomic, strong) GetRateResult *getRateResult;
@property(nonatomic, strong) TransferService *transferService;
@property(nonatomic, strong) Get_token_info_service *get_token_info_service;
@property(nonatomic , strong) TokenInfo *currentToken;
@property(nonatomic , copy) NSString *assest_price_cny;
@property(nonatomic , strong) UIView *shareBaseView;
@property(nonatomic , strong) SocialSharePanelView *socialSharePanelView;
@property(nonatomic , strong) AssestsShareDetailView *assestsShareDetailView;
@property(nonatomic , strong) NSArray *platformNameArr;
@end

@implementation RecieveViewController

- (NavigationView *)navView{
    if (!_navView) {
//         _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_back" title:NSLocalizedString(@"资产收款", nil) rightBtnTitleName:NSLocalizedString(@"收款记录", nil) delegate:self];
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_navi_back" title:NSLocalizedString(@"资产收款", nil) rightBtnImgName:@"icon_share" delegate:self];
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

- (RecieveHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"RecieveHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 667);
        _headerView.delegate = self;
        _headerView.amountTF.delegate = self;
    }
    return _headerView;
}

- (RecieveQRCodeView *)recieveQRCodeView{
    if (!_recieveQRCodeView) {
        _recieveQRCodeView = [[[NSBundle mainBundle] loadNibNamed:@"RecieveQRCodeView" owner:nil options:nil] firstObject];
        _recieveQRCodeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _recieveQRCodeView;
}

- (AssestsShareDetailView *)assestsShareDetailView{
    if (!_assestsShareDetailView) {
        _assestsShareDetailView = [[[NSBundle mainBundle] loadNibNamed:@"AssestsShareDetailView" owner:nil options:nil] firstObject];
        _assestsShareDetailView.backgroundColor = HEXCOLOR(0xF7F7F7);
    }
    return _assestsShareDetailView;
}

- (SocialSharePanelView *)socialSharePanelView{
    if (!_socialSharePanelView) {
        _socialSharePanelView = [[SocialSharePanelView alloc] init];
        _socialSharePanelView.backgroundColor = HEXCOLOR(0xF7F7F7);
        _socialSharePanelView.delegate = self;
        NSMutableArray *modelArr = [NSMutableArray array];
        NSArray *titleArr = @[NSLocalizedString(@"微信好友", nil),NSLocalizedString(@"朋友圈", nil)];//, NSLocalizedString(@"QQ好友", nil), NSLocalizedString(@"QQ空间", nil)
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
        _platformNameArr = @[@"wechat_friends",@"wechat_moments", @"qq_friends", @"qq_Zone"];
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
        topView.sd_layout.leftSpaceToView(_shareBaseView, 0).rightSpaceToView(_shareBaseView, 0).topSpaceToView(_shareBaseView, 0).heightIs(SCREEN_HEIGHT - 47 - 116 - 153);
        
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
        
        [_shareBaseView addSubview: self.assestsShareDetailView];
        _assestsShareDetailView.sd_layout.leftSpaceToView(_shareBaseView, 0).rightSpaceToView(_shareBaseView, 0).bottomSpaceToView(_socialSharePanelView, 0).heightIs(153);
        
    }
    return _shareBaseView;
}

- (TransactionRecordsService *)transactionRecordsService{
    if (!_transactionRecordsService) {
        _transactionRecordsService = [[TransactionRecordsService alloc] init];
    }
    return _transactionRecordsService;
}

- (TransferService *)transferService{
    if (!_transferService) {
        _transferService = [[TransferService alloc] init];
    }
    return _transferService;
}

- (Get_token_info_service *)get_token_info_service{
    if (!_get_token_info_service) {
        _get_token_info_service = [[Get_token_info_service alloc] init];
    }
    return _get_token_info_service;
}

- (NSMutableArray *)get_token_info_service_data_array{
    if (!_get_token_info_service_data_array) {
        _get_token_info_service_data_array = [[NSMutableArray alloc] init];
    }
    return _get_token_info_service_data_array;
}

// 隐藏自带的导航栏
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.transferModel) {
        self.currentAssestsType = self.transferModel.coin;
        for (TokenInfo *token in self.get_token_info_service_data_array) {
            if ([token.token_symbol isEqualToString:self.currentAssestsType]) {
                self.currentToken = token;
            }
        }
    }else{
        if (self.get_token_info_service_data_array.count > 0) {
            self.currentToken = self.get_token_info_service_data_array[0];
            self.currentAssestsType = self.currentToken.token_symbol;
            
        }
    }
    // 设置默认资产
    self.headerView.assestChooserLabel.text = self.currentAssestsType;
    self.headerView.assetLogoImg.image = [UIImage imageNamed:@"logo_van_green"];
    self.headerView.accountTFLabel.text = CURRENT_ACCOUNT_NAME;
//    self.headerView.generateQRCodeBtn.layer.masksToBounds = YES;
//    self.headerView.generateQRCodeBtn.layer.cornerRadius = 5.0;
    [self requestRate];
    [MobClick beginLogPageView:@"VKToken收款"]; //("Pagename"为页面名称，可自定义)
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"VKToken收款"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
//    self.view.lee_theme.LeeConfigBackgroundColor(@"baseHeaderView_background_color");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:self.headerView.amountTF];
}

- (void)requestRate{
    WS(weakSelf);
    NSArray *tmpArr = [ArchiveUtil unarchiveTokenInfoArray];
    for (TokenInfo *token in tmpArr) {
        {//self.get_token_info_service_data_array
            if ([token.token_symbol isEqualToString:self.currentAssestsType]) {
                self.assest_price_cny = token.asset_price_cny;
                [self textFieldChange:nil];
            }
        }
    }
}

- (void)requestTokenInfoDataArray{
    self.get_token_info_service.get_token_info_request.accountName = CURRENT_ACCOUNT_NAME;
    WS(weakSelf);
    [self.get_token_info_service get_token_info:^(id service, BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.get_token_info_service_data_array = weakSelf.get_token_info_service.dataSourceArray;
            if (weakSelf.get_token_info_service_data_array.count > 0) {
                weakSelf.currentToken = weakSelf.get_token_info_service_data_array[0];
                weakSelf.currentAssestsType = weakSelf.currentToken.token_symbol;
                weakSelf.headerView.assestChooserLabel.text = weakSelf.currentToken.token_symbol;
                
                [weakSelf requestRate];
            }else{
                [TOASTVIEW showWithText: NSLocalizedString(@"当前账号未添加资产", nil)];
                return;
            }
        }
    }];
}

- (void)textFieldChange:(NSNotification *)notification {
//    BOOL isCanSubmit = self.headerView.amountTF.text.length != 0;
//    if (isCanSubmit) {
//        self.headerView.generateQRCodeBtn.lee_theme
//        .LeeConfigBackgroundColor(@"confirmButtonNormalStateBackgroundColor");
//    } else {
//        self.headerView.generateQRCodeBtn.lee_theme
//        .LeeAddBackgroundColor(SOCIAL_MODE, HEXCOLOR(0xCCCCCC))
//        .LeeAddBackgroundColor(BLACKBOX_MODE, HEXCOLOR(0xA3A3A3));
//    }
//    self.headerView.generateQRCodeBtn.enabled = isCanSubmit;
    if (IsStrEmpty(self.currentToken.coinmarket_id)  ) {
//        self.headerView.tipLabel.text = [NSString stringWithFormat:@"≈0CNY"];
    }else{
//        self.headerView.tipLabel.text = [NSString stringWithFormat:@"≈%@CNY" , [NumberFormatter displayStringFromNumber:@(self.headerView.amountTF.text.doubleValue * self.assest_price_cny.doubleValue)]];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:VALIDATE_STRING(CURRENT_ACCOUNT_NAME)  forKey:@"account_name"];
        [dic setObject:VALIDATE_STRING(self.currentAssestsType)  forKey:@"token"];
        [dic setObject:VALIDATE_STRING(self.headerView.amountTF.text)  forKey:@"quantity"];
        [dic setObject:VALIDATE_STRING(self.currentToken.contract_name)  forKey:@"contract"];
        [dic setObject:@"token_make_collections_QRCode"  forKey:@"type"];
        
        //钱包二维码
        NSString *QRCodeJsonStr = [dic mj_JSONString];
        self.headerView.recieveAssestsQRCodeImg.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:QRCodeJsonStr logoImageName:@"logo_bg_blue" logoScaleToSuperView:0.2];
    }
}


// navigationViewDelegate
- (void)leftBtnDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnDidClick{
    [self.view addSubview:self.shareBaseView];
    self.shareBaseView.sd_layout.leftSpaceToView(self.view, 0).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).heightIs(SCREEN_HEIGHT);
    self.assestsShareDetailView.referencePriceLabel.text = [NSString stringWithFormat:@"¥%@", [NumberFormatter displayStringFromNumber:@(self.currentToken.asset_price_cny.doubleValue)]];

    if ([self.currentToken.asset_price_change_in_24h hasPrefix:@"-"]) {
        self.assestsShareDetailView.priceChangeIn24hLabel.text = [NSString stringWithFormat:@"%@%%", self.currentToken.asset_price_change_in_24h];
    }else{
        self.assestsShareDetailView.priceChangeIn24hLabel.text = [NSString stringWithFormat:@"+%@%%", self.currentToken.asset_price_change_in_24h];
    }
    self.assestsShareDetailView.totalMarketCapitalizationLabel.text = [NSString stringWithFormat:@"¥%@", [NumberFormatter displayStringFromNumber:@(self.currentToken.asset_market_cap_cny.doubleValue)]];
}

- (void)dismiss{
    [self.shareBaseView removeFromSuperview];
}

- (void)cancelShareAssestsDetail{
    [self.shareBaseView removeFromSuperview];
}

// SocialSharePanelViewDelegate
- (void)SocialSharePanelViewDidTap:(UITapGestureRecognizer *)sender{
    NSString *platformName = self.platformNameArr[sender.view.tag-1000];
    ShareModel *model = [[ShareModel alloc] init];
    if ([self.currentToken.token_symbol isEqualToString:@"VKT"]) {
        model.imageName = @"vkt_avatar";
    }else if ([self.currentToken.token_symbol isEqualToString:@"OCT"]){
        model.imageName = @"oct_avatar";
    }else{
        model.imageName = @"logo_bg_blue";
    }
    model.title = [NSString stringWithFormat:@"%@%@",self.currentToken.token_symbol, NSLocalizedString(@"最新咨询详情", nil)];
    
    NSString *priceChange ;
    if ([self.currentToken.asset_price_change_in_24h hasPrefix:@"-"]) {
        priceChange = [NSString stringWithFormat:@"%@%%", self.currentToken.asset_price_change_in_24h];
    }else{
        priceChange = [NSString stringWithFormat:@"+%@%%", self.currentToken.asset_price_change_in_24h];
    }
    model.detailDescription = [NSString stringWithFormat:@"%@%@\n%@%@\n%@¥%@\n", NSLocalizedString(@"参考价格", nil),[NSString stringWithFormat:@"¥%@", [NumberFormatter displayStringFromNumber:@(self.currentToken.asset_price_cny.doubleValue)]], NSLocalizedString(@"24小时涨跌幅", nil), priceChange,NSLocalizedString(@"总市值", nil), [NumberFormatter displayStringFromNumber:@(self.currentToken.asset_market_cap_cny.doubleValue)]];
    model.webPageUrl = @"http://www.vankia.net";
    NSLog(@"%@", platformName);
    if ([platformName isEqualToString:@"wechat_friends"]) {
        [[SocialManager socialManager] wechatShareToScene:0 withShareModel:model];
    }else if ([platformName isEqualToString:@"wechat_moments"]){
        [[SocialManager socialManager] wechatShareToScene:1 withShareModel:model];
    }else if ([platformName isEqualToString:@"qq_friends"]){
        [[SocialManager socialManager] qqShareToScene:0 withShareModel:model];
    }else if ([platformName isEqualToString:@"qq_Zone"]){
        [[SocialManager socialManager] qqShareToScene:1 withShareModel:model];
    }
}

// headerViewDelegate
- (void)selectAssestsBtnDidClick:(UIButton *)sender {
    WS(weakSelf);
    [self.view endEditing:YES];
    NSMutableArray *assestsArr = [NSMutableArray array];
    CDZPickerBuilder *builder = [CDZPickerBuilder new];
    builder.cancelText = NSLocalizedString(@"选择您的Token", nil);
    for (int i = 0 ; i < self.get_token_info_service_data_array.count; i++) {
        TokenInfo *token = self.get_token_info_service_data_array[i];
        if ([token.token_symbol isEqualToString:self.currentToken.token_symbol]) {
            builder.defaultIndex = i;
        }
        [assestsArr addObject: token.token_symbol];
    }
    
    if (assestsArr.count == 0) {
        return;
    }
    [CDZPicker showSinglePickerInView:self.view withBuilder:builder strings:assestsArr confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        weakSelf.currentAssestsType = VALIDATE_STRING(strings[0]);
        weakSelf.headerView.assestChooserLabel.text = weakSelf.currentAssestsType;
        for (TokenInfo *token in self.get_token_info_service_data_array) {
            if ([token.token_symbol isEqualToString:self.currentAssestsType]) {
                weakSelf.currentToken = token;
            }
        }
        [weakSelf requestRate];
    }cancel:^{
        NSLog(@"user cancled");
    }];
}

- (void)createQRCodeBtnDidClick:(UIButton *)sender{
    [self.view endEditing:YES];
    [self.view addSubview:self.recieveQRCodeView];
    self.recieveQRCodeView.amountLabel.text = self.headerView.amountTF.text;
    self.recieveQRCodeView.assestTypeLabel.text = [NSString stringWithFormat:@"/ %@", self.currentAssestsType];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:VALIDATE_STRING(CURRENT_ACCOUNT_NAME)  forKey:@"account_name"];
    [dic setObject:VALIDATE_STRING(self.currentAssestsType)  forKey:@"token"];
    [dic setObject:VALIDATE_STRING(self.headerView.amountTF.text)  forKey:@"quantity"];
    [dic setObject:VALIDATE_STRING(self.currentToken.contract_name)  forKey:@"contract"];
    [dic setObject:@"token_make_collections_QRCode"  forKey:@"type"];
    
    //钱包二维码
    NSString *QRCodeJsonStr = [dic mj_JSONString];
    self.recieveQRCodeView.recieveAssestsQRCodeImg.image = [SGQRCodeGenerateManager generateWithLogoQRCodeData:QRCodeJsonStr logoImageName:@"logo_bg_blue" logoScaleToSuperView:0.2];
}

- (void)removeRecieveQRCodeView{
    [self.recieveQRCodeView removeFromSuperview];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
@end
