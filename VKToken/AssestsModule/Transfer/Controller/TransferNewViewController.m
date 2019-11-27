//
//  TransferNewViewController.m
//  VKToken
//
//  Created by vankiachain on 2017/12/5.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "TransferNewViewController.h"
#import "TransferHeaderView.h"
#import "NavigationView.h"
#import "Assest.h"
#import "ScanQRCodeViewController.h"
#import "ChangeAccountViewController.h"
#import "TransferService.h"
#import "TransactionResult.h"
#import "VKTResourceService.h"
#import "AssestsMainService.h"
#import "Account.h"
#import "GetRateResult.h"
#import "Rate.h"
#import "TransactionRecordsService.h"
#import "TransactionRecordTableViewCell.h"
#import "TransactionRecord.h"
#import "Follow.h"
#import "WalletAccount.h"
#import "TransferAbi_json_to_bin_request.h"
#import "Get_token_info_service.h"
#import "TransferRecordsViewController.h"
#import "ContactTableViewController.h"
#import "VKToken-swift.h"

@interface TransferNewViewController ()<UIGestureRecognizerDelegate, UITableViewDelegate , UITableViewDataSource, NavigationViewDelegate, TransferHeaderViewDelegate, ChangeAccountViewControllerDelegate,ChangeContactViewControllerDelegate, UITextFieldDelegate, TransferServiceDelegate, LoginPasswordViewDelegate>
@property(nonatomic, strong) NavigationView *navView;
@property(nonatomic, strong) TransferHeaderView *headerView;
@property(nonatomic, strong) TransferService *mainService;
@property(nonatomic, strong) Get_token_info_service *get_token_info_service;
@property(nonatomic, strong) AssestsMainService *assestsMainService;
@property(nonatomic, strong) GetRateResult *getRateResult;
@property(nonatomic, strong) TransactionRecordsService *transactionRecordsService;
@property(nonatomic, strong) LoginPasswordView *loginPasswordView;
@property(nonatomic , strong) TransferAbi_json_to_bin_request *transferAbi_json_to_bin_request;
@property(nonatomic , strong) VKTResourceService *vktResourceService;
@property(nonatomic , copy) NSString *assest_price_cny;

@end

@implementation TransferNewViewController


- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_back" title:NSLocalizedString(@"资产转账", nil) rightBtnImgName:@"scan_black" delegate:self];
        _navView.leftBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal);
    }
    return _navView;
}

- (TransferHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"TransferHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 520);
        _headerView.delegate = self;
        _headerView.amountTF.delegate = self;
        _headerView.nameTF.delegate = self;
    }
    return _headerView;
}


- (TransferService *)mainService{
    if (!_mainService) {
        _mainService = [[TransferService alloc] init];
        _mainService.delegate = self;
    }
    return _mainService;
}

- (VKTResourceService *)vktResourceService{
    if (!_vktResourceService) {
        _vktResourceService = [[VKTResourceService alloc] init];
    }
    return _vktResourceService;
}

- (Get_token_info_service *)get_token_info_service{
    if (!_get_token_info_service) {
        _get_token_info_service = [[Get_token_info_service alloc] init];
    }
    return _get_token_info_service;
}

- (TransactionRecordsService *)transactionRecordsService{
    if (!_transactionRecordsService) {
        _transactionRecordsService = [[TransactionRecordsService alloc] init];
    }
    return _transactionRecordsService;
}

- (AssestsMainService *)assestsMainService{
    if (!_assestsMainService) {
        _assestsMainService = [[AssestsMainService alloc] init];
    }
    return _assestsMainService;
}

- (LoginPasswordView *)loginPasswordView{
    if (!_loginPasswordView) {
        _loginPasswordView = [[[NSBundle mainBundle] loadNibNamed:@"LoginPasswordView" owner:nil options:nil] firstObject];
        _loginPasswordView.frame = self.view.bounds;
        _loginPasswordView.delegate = self;
    }
    return _loginPasswordView;
}

- (TransferAbi_json_to_bin_request *)transferAbi_json_to_bin_request{
    if (!_transferAbi_json_to_bin_request) {
        _transferAbi_json_to_bin_request = [[TransferAbi_json_to_bin_request alloc] init];
    }
    return _transferAbi_json_to_bin_request;
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
    [MobClick beginLogPageView:@"VKToken转账"]; //("Pagename"为页面名称，可自定义)
    
    // 设置默认的转账账号及资产
    if (self.transferModel || self.recieveTokenModel) {
        if (self.transferModel) {
            self.headerView.nameTF.text = self.transferModel.account_name;
            self.headerView.amountTF.text = self.transferModel.money;
            self.currentAssestsType = self.transferModel.coin;
            [self requestTokenInfoDataArray];
        }else if (self.recieveTokenModel){
            self.headerView.nameTF.text = self.recieveTokenModel.account_name;
            self.headerView.amountTF.text = self.recieveTokenModel.quantity;
            self.headerView.memoTV.text = self.recieveTokenModel.memo;
            self.currentAssestsType = self.recieveTokenModel.token;
        }
        self.headerView.assestChooserLabel.text = self.currentAssestsType;
        self.headerView.nameFromTF.text = CURRENT_ACCOUNT_NAME;
        for (TokenInfo *token in self.get_token_info_service_data_array) {
            if ([token.token_symbol isEqualToString:self.currentAssestsType]) {
                self.currentToken = token;
            }
        }
        
    }else{
        if (self.get_token_info_service_data_array.count > 0) {
            for (TokenInfo *token in self.get_token_info_service_data_array) {
                if ([token.token_symbol isEqualToString:self.currentAssestsType] && [token.account_name isEqualToString:self.fromAccount]) {
                    self.currentToken = token;
                }
            }
            self.currentAssestsType = self.currentToken.token_symbol;
            self.headerView.assestChooserLabel.text = self.currentToken.token_symbol;
            self.headerView.nameFromTF.text = self.currentToken.account_name;
            self.headerView.transferBtn.layer.masksToBounds = YES;
            self.headerView.transferBtn.layer.cornerRadius = 5.0;
        }else{
            [TOASTVIEW showWithText: NSLocalizedString(@"当前账号未添加资产", nil)];
            return;
        }
    }
    self.headerView.transferBtn.layer.cornerRadius = 5.0f;
    [self requestRate];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"转账"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
    self.view.lee_theme.LeeConfigBackgroundColor(@"baseHeaderView_background_color");
    
//    [self requestRichList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:self.headerView.nameTF];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:self.headerView.amountTF];
    self.fromAccount = CURRENT_ACCOUNT_NAME;
}

- (void)requestRichList{
    self.mainService.richListRequest.uid = CURRENT_WALLET_UID;
    [self.mainService getRichlistAccount:^(id service, BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"getRichlistAccountSuccess");
        }
    }];
}

- (void)requestRate{
    NSArray *tmpArr = [ArchiveUtil unarchiveTokenInfoArray];
    for (TokenInfo *token in tmpArr) {
        {// self.get_token_info_service_data_array
            if ([token.token_symbol isEqualToString:self.currentAssestsType]) {
                self.assest_price_cny = token.asset_price_cny;
                [self configHeaderView];
                [self textFieldChange:nil];
            }
        }
    }

}

- (void)requestTokenInfoDataArray{
    NSMutableArray *paramsArr = [NSMutableArray array];
    [paramsArr addObject:self.fromAccount];
    self.get_token_info_service.get_token_info_request.accountNameArr = paramsArr;
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

- (void)configHeaderView{
    self.headerView.assestChooserLabel.text = self.currentAssestsType;
    self.headerView.assest_balanceLabel.text = [NSString stringWithFormat:@"%@ %@", [NumberFormatter displayStringFromNumber:@(self.currentToken.balance.doubleValue-self.currentToken.locked_amount.doubleValue)], self.currentToken.token_symbol];
    self.headerView.assest_balance_ConvertLabel.text = [NSString stringWithFormat:@"≈%@CNY", [NumberFormatter displayStringFromNumber:[NSNumber numberWithDouble:self.currentToken.balance_cny.doubleValue]]];
//    self.headerView.amount_ConvertLabel.text = [NSString stringWithFormat:@"≈%@CNY" , [NumberFormatter displayStringFromNumber:@(self.headerView.amountTF.text.doubleValue * self.getRateResult.data.price_cny.doubleValue)]];
}

- (void)textFieldChange:(NSNotification *)notification {
    BOOL isCanSubmit = (self.headerView.nameTF.text.length != 0 && self.headerView.amountTF.text.length != 0 && [self.headerView.amountTF.text doubleValue] >= 0.0001);
    if (isCanSubmit) {
        
        self.headerView.transferBtn.lee_theme
        .LeeConfigBackgroundColor(@"confirmButtonNormalStateBackgroundColor");
    } else {
        self.headerView.transferBtn.lee_theme
        .LeeAddBackgroundColor(SOCIAL_MODE, HEXCOLOR(0xCCCCCC))
        .LeeAddBackgroundColor(BLACKBOX_MODE, HEXCOLOR(0xA3A3A3));
    }
    self.headerView.transferBtn.enabled = isCanSubmit;
    if (IsStrEmpty(self.currentToken.coinmarket_id)  ) {
        self.headerView.amount_ConvertLabel.text = [NSString stringWithFormat:@"≈0CNY"];
    }else{
        self.headerView.amount_ConvertLabel.text = [NSString stringWithFormat:@"≈%@CNY" , [NumberFormatter displayStringFromNumber:@(self.headerView.amountTF.text.doubleValue * self.assest_price_cny.doubleValue)]];
        
    }
}

- (void)leftBtnDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnDidClick{
    WS(weakSelf);
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        ScanQRCodeViewController *vc = [[ScanQRCodeViewController alloc] init];
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    });
                    // 用户第一次同意了访问相机权限
                    NSLog(NSLocalizedString(@"用户第一次同意了访问相机权限 - - %@", nil), [NSThread currentThread]);
                }else {
                    // 用户第一次拒绝了访问相机权限
                    NSLog(NSLocalizedString(@"用户第一次拒绝了访问相机权限 - - %@", nil), [NSThread currentThread]);
                }
                
                
            }];
        }else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            ScanQRCodeViewController *vc = [[ScanQRCodeViewController alloc] init];
            vc.get_token_info_service_data_array = self.get_token_info_service.dataSourceArray;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"温馨提示", nil)message:NSLocalizedString(@"请去-> [设置 - 隐私 - 相机 - VKT Wallet] 打开访问开关", nil)preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil)style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [weakSelf presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(NSLocalizedString(@"因为系统原因, 无法访问相册", nil));
        }
        
        
    }else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"温馨提示", nil)message:NSLocalizedString(@"未检测到您的摄像头", nil)preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil)style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [weakSelf presentViewController:alertC animated:YES completion:nil];
    }
}

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


- (void)selectAccountBtnDidClick:(UIButton *)sender {
    
    NSArray *accountArr = [[AccountsTableManager accountTable] selectAllNativeAccountName];
    

    WS(weakSelf);
    [CDZPicker showSinglePickerInView:self.view withBuilder:[CDZPickerBuilder new] strings:accountArr confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        weakSelf.fromAccount = VALIDATE_STRING(strings[0]);
        weakSelf.headerView.nameFromTF.text = weakSelf.fromAccount;

        for (TokenInfo *token in self.get_token_info_service_data_array) {
            if ([token.token_symbol isEqualToString:self.currentAssestsType] && [token.account_name isEqualToString:weakSelf.fromAccount]) {
                weakSelf.currentToken = token;
            }
        }
        [weakSelf requestRate];
        
    }cancel:^{
        NSLog(@"user cancled");
    }];
    
}

- (void)contactBtnDidClick:(UIButton *)sender {
//    ChangeAccountViewController *vc = [[ChangeAccountViewController alloc] init];
//    NSMutableArray *temp = [NSMutableArray array];
//    for (Follow *follow in self.mainService.richListDataArray) {
//        WalletAccount *walletAccount = [[WalletAccount alloc] init];
//        walletAccount.vktAccountName = follow.displayName;
//        [temp addObject:walletAccount];
//    }
//    vc.dataArray = temp;
//    vc.changeAccountDataArrayType = ChangeAccountDataArrayTypeNetworking;
//    vc.delegate = self;
    //创建tableView视图控制器
    ContactTableViewController *vc = [[ContactTableViewController alloc] init];
    vc.changeContactDataArrayType = ChangeContactDataArrayTypeNetworking;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

//ChangeContactViewControllerDelegate
-(void)changeContactCellDidClick:(NSString *)name{
    NSLog(@"%@" ,name);
    self.headerView.nameTF.text = name;
}

- (void)transferBtnDidClick:(UIButton *)sender {
    if (IsStrEmpty(self.headerView.nameTF.text)) {
        [TOASTVIEW showWithText:@"收币人不能为空"];
        return;
    }
    if (IsStrEmpty(self.headerView.amountTF.text)) {
        [TOASTVIEW showWithText:@"请填写金额"];
        return;
    }
    [self.view addSubview:self.loginPasswordView];
}

// loginPasswordViewDelegate
- (void)cancleBtnDidClick:(UIButton *)sender{
    [self removeLoginPasswordView];
}

- (void)confirmBtnDidClick:(UIButton *)sender{
    
    [self isExistAccount];
    
}

// TransferServiceDelegate
-(void)pushTransactionDidFinish:(TransactionResult *)result{
    if ([result.code isEqualToNumber:@0 ]) {
        [TOASTVIEW showWithText:NSLocalizedString(@"转账成功", nil)];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [TOASTVIEW showWithText: result.message];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)isExistAccount{
    WS(weakSelf);
    self.vktResourceService.getAccountRequest.name = self.headerView.nameTF.text;
    [self.vktResourceService get_account:^(VKTResourceResult *result, BOOL isSuccess) {
        if (isSuccess) {
            if([result.message isEqualToString:@"ok"]){
                // 验证密码输入是否正确
                TokenCoreVKT *tokenCoreVKT = [TokenCoreVKT sharedTokenCoreVKT];
                
                AccountInfo *model = [[AccountsTableManager accountTable] selectAccountTableWithAccountName: self.headerView.nameFromTF.text];
                Wallet *current_wallet = CURRENT_WALLET;

                if (![WalletUtil validateWalletPasswordWithSha256:current_wallet.wallet_shapwd password:self.loginPasswordView.inputPasswordTF.text]) {
                    [TOASTVIEW showWithText:NSLocalizedString(@"密码输入错误!", nil)];
                    return;
                }
                if (IsNilOrNull(self.currentToken)) {
                    [TOASTVIEW showWithText: NSLocalizedString(@"当前账号未添加资产", nil)];
                    return;
                }
                self.transferAbi_json_to_bin_request.code = self.currentToken.contract_name;
                
                if ([self.currentToken.balance isEqualToString:@"0"] || ( self.currentToken.balance.doubleValue  < self.headerView.amountTF.text.doubleValue)) {
                    [TOASTVIEW showWithText: NSLocalizedString(@"可用余额不足", nil)];
                    [self removeLoginPasswordView];
                    return;
                }else{
                    
                    NSString *percision = [NSString stringWithFormat:@"%lu", [NSString getDecimalStringPercisionWithDecimalStr:self.currentToken.balance]];
                    self.transferAbi_json_to_bin_request.quantity = [NSString stringWithFormat:@"%@ %@", [NSString stringWithFormat:@"%.*f", percision.intValue, self.headerView.amountTF.text.doubleValue], self.currentToken.token_symbol];
                }
                
                self.transferAbi_json_to_bin_request.action = ContractAction_TRANSFER;
                self.transferAbi_json_to_bin_request.from = self.fromAccount;
                self.transferAbi_json_to_bin_request.to = self.headerView.nameTF.text;
                self.transferAbi_json_to_bin_request.memo = self.headerView.memoTV.text;
                WS(weakSelf);
                [self.transferAbi_json_to_bin_request postOuterDataSuccess:^(id DAO, id data) {
            #pragma mark -- [@"data"]
                    BaseResult *result = [BaseResult mj_objectWithKeyValues:data];
                    if (![result.code isEqualToNumber:@0]) {
                        [TOASTVIEW showWithText:result.message];
                        [weakSelf cancleBtnDidClick:nil];
                        return ;
                    }
                    NSLog(@"approve_abi_to_json_request_success: --binargs: %@",data[@"data"][@"binargs"] );
                    AccountInfo *model = [[AccountsTableManager accountTable] selectAccountTableWithAccountName: self.headerView.nameFromTF.text];
                    weakSelf.mainService.available_keys = @[VALIDATE_STRING(model.account_owner_public_key) , VALIDATE_STRING(model.account_active_public_key)];
                    
                    weakSelf.mainService.action = ContractAction_TRANSFER;
                    weakSelf.mainService.code = weakSelf.currentToken.contract_name;
                    weakSelf.mainService.sender = weakSelf.fromAccount;
            #pragma mark -- [@"data"]
                    weakSelf.mainService.binargs = data[@"data"][@"binargs"];
                    weakSelf.mainService.pushTransactionType = PushTransactionTypeTransfer;
                    weakSelf.mainService.password = weakSelf.loginPasswordView.inputPasswordTF.text;
                    [weakSelf.mainService pushTransaction];
                    [weakSelf removeLoginPasswordView];
                } failure:^(id DAO, NSError *error) {
                    NSLog(@"%@", error);
                }];
            }else{
                [self removeLoginPasswordView];
                [TOASTVIEW showWithText: NSLocalizedString(@"链上无此接收人", nil)];
            }
        }else{
            [TOASTVIEW showWithText: NSLocalizedString(@"网络异常", nil)];
        }
    }];
    
}

- (void)removeLoginPasswordView{
    [self.loginPasswordView removeFromSuperview];
    self.loginPasswordView = nil;
}
@end

