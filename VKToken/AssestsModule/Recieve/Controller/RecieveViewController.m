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
@end

@implementation RecieveViewController

- (NavigationView *)navView{
    if (!_navView) {
//         _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_back" title:NSLocalizedString(@"资产收款", nil) rightBtnTitleName:NSLocalizedString(@"收款记录", nil) delegate:self];
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_navi_back" title:NSLocalizedString(@"资产收款", nil) rightBtnTitleName:NSLocalizedString(@"", nil) delegate:self];
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
    [MobClick event:@"收款_转账记录"];
    TransferRecordsViewController *vc = [[TransferRecordsViewController alloc] init];
    vc.get_token_info_service_data_array = self.get_token_info_service_data_array;
    vc.currentToken = self.currentToken;
    vc.to = CURRENT_ACCOUNT_NAME;
    [self.navigationController pushViewController:vc animated:YES];
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
