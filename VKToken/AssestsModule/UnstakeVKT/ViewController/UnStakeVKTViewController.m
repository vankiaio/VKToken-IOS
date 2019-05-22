//
//  UnStakeVKTViewController.m
//  VKToken
//
//  Created by vankiachain on 2018/6/15.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "UnStakeVKTViewController.h"
#import "UnstakeVktAbiJsonTobinRequest.h"
#import "AssestsMainService.h"
#import "TransferService.h"
#import "UnStakeVKTHeaderView.h"
#import "NavigationView.h"
#import "AccountResult.h"
#import "Account.h"

@interface UnStakeVKTViewController ()<LoginPasswordViewDelegate, TransferServiceDelegate, UnStakeVKTHeaderViewDelegate, NavigationViewDelegate>
@property(nonatomic , strong) UnstakeVktAbiJsonTobinRequest *unstakeVktAbiJsonTobinRequest;
@property(nonatomic , strong) AssestsMainService *assestsMainService;
@property(nonatomic , strong) TransferService *transferService;
@property(nonatomic, strong) LoginPasswordView *loginPasswordView;
@property(nonatomic, strong) NavigationView *navView;
@property(nonatomic, strong) UnStakeVKTHeaderView *headerView;
@property(nonatomic , strong) AccountResult *accountResult;
@end

@implementation UnStakeVKTViewController

- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"back" title:NSLocalizedString(@"赎回VKT", nil)rightBtnTitleName:NSLocalizedString(@"", nil)delegate:self];
        _navView.leftBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"back_white"], UIControlStateNormal);
    }
    return _navView;
}

- (UnStakeVKTHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"UnStakeVKTHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, 400);
        _headerView.delegate = self;
    }
    return _headerView;
}

- (UnstakeVktAbiJsonTobinRequest *)unstakeVktAbiJsonTobinRequest{
    if (!_unstakeVktAbiJsonTobinRequest) {
        _unstakeVktAbiJsonTobinRequest = [[UnstakeVktAbiJsonTobinRequest alloc] init];
    }
    return _unstakeVktAbiJsonTobinRequest;
}

- (AssestsMainService *)assestsMainService{
    if (!_assestsMainService) {
        _assestsMainService = [[AssestsMainService alloc] init];
    }
    return _assestsMainService;
}

- (TransferService *)transferService{
    if (!_transferService) {
        _transferService = [[TransferService alloc] init];
        _transferService.delegate = self;
    }
    return _transferService;
}

- (LoginPasswordView *)loginPasswordView{
    if (!_loginPasswordView) {
        _loginPasswordView = [[[NSBundle mainBundle] loadNibNamed:@"LoginPasswordView" owner:nil options:nil] firstObject];
        _loginPasswordView.frame = self.view.bounds;
        _loginPasswordView.delegate = self;
    }
    return _loginPasswordView;
}

- (AccountResult *)accountResult{
    if (!_accountResult) {
        _accountResult = [[AccountResult alloc] init];
    }
    return _accountResult;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.headerView];
    
    
    [self buidDataSource];
    
}


// 构建数据源
- (void)buidDataSource{
    WS(weakSelf);
    if (IsNilOrNull(self.currentAccountName)) {
        return;
    }
    self.assestsMainService.getAccountAssetRequest.name = self.currentAccountName;
    [self.assestsMainService get_account_asset:^(AccountResult *result, BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.accountResult = result;
            weakSelf.headerView.model = weakSelf.accountResult;
                if (self.accountResult.data.vkt_net_weight.doubleValue > 1 &&  self.accountResult.data.vkt_cpu_weight.doubleValue > 1) {
                    self.headerView.confirmBtn.lee_theme
                    .LeeConfigBackgroundColor(@"confirmButtonNormalStateBackgroundColor");
                    [self.headerView.confirmBtn setTitle:NSLocalizedString(@"确认赎回", nil) forState:(UIControlStateNormal)];
                    self.headerView.confirmBtn.enabled =  YES;
                }else{
                    self.headerView.confirmBtn.lee_theme
                    .LeeAddBackgroundColor(SOCIAL_MODE, HEXCOLOR(0xCCCCCC))
                    .LeeAddBackgroundColor(BLACKBOX_MODE, HEXCOLOR(0xA3A3A3));
                    [self.headerView.confirmBtn setTitle:NSLocalizedString(@"无法赎回", nil) forState:(UIControlStateNormal)];
                    self.headerView.confirmBtn.enabled =  NO;
                }
                
        }
    }];
}


- (void)confirmUnStakeBtnDidClick{
    [self.view addSubview:self.loginPasswordView];
}

// loginPasswordViewDelegate
- (void)cancleBtnDidClick:(UIButton *)sender{
    [self.loginPasswordView removeFromSuperview];
}

- (void)confirmBtnDidClick:(UIButton *)sender{

    // 验证密码输入是否正确
    Wallet *current_wallet = CURRENT_WALLET;
    if (![WalletUtil validateWalletPasswordWithSha256:current_wallet.wallet_shapwd password:self.loginPasswordView.inputPasswordTF.text]) {
        [TOASTVIEW showWithText:NSLocalizedString(@"密码输入错误!", nil)];
        return;
    }

    if (self.accountResult.data.vkt_net_weight.doubleValue > 1 &&  self.accountResult.data.vkt_cpu_weight.doubleValue > 1) {
        [self unstakeVKT];
    }else{
        [TOASTVIEW showWithText:@"无法赎回"];
        [self.loginPasswordView removeFromSuperview];
        return;
    }
}

// 一键赎回质押的VKT
- (void)unstakeVKT{
    [SVProgressHUD show];
    self.unstakeVktAbiJsonTobinRequest.action = ContractAction_UNDELEGATEBW;
    self.unstakeVktAbiJsonTobinRequest.code = ContractName_VKTIO;
    self.unstakeVktAbiJsonTobinRequest.from = self.accountResult.data.account_name;
    self.unstakeVktAbiJsonTobinRequest.receiver = self.accountResult.data.account_name;
    self.unstakeVktAbiJsonTobinRequest.unstake_net_quantity = [NSString stringWithFormat:@"%.4f VKT", self.accountResult.data.vkt_net_weight.doubleValue-1];
    self.unstakeVktAbiJsonTobinRequest.unstake_cpu_quantity = [NSString stringWithFormat:@"%.4f VKT", self.accountResult.data.vkt_cpu_weight.doubleValue-1];
    WS(weakSelf);
    [self.unstakeVktAbiJsonTobinRequest postOuterDataSuccess:^(id DAO, id data) {
#pragma mark -- [@"data"]
        NSLog(@"approve_abi_to_json_request_success: --binargs: %@",data[@"data"][@"binargs"] );
        AccountInfo *accountInfo = [[AccountsTableManager accountTable] selectAccountTableWithAccountName:weakSelf.accountResult.data.account_name];
        if (!accountInfo) {
            [TOASTVIEW showWithText: NSLocalizedString(@"本地无此账号!", nil) ];
            return ;
        }
        weakSelf.transferService.available_keys = @[VALIDATE_STRING(accountInfo.account_owner_public_key) , VALIDATE_STRING(accountInfo.account_active_public_key)];
        weakSelf.transferService.action = ContractAction_UNDELEGATEBW;
        weakSelf.transferService.sender = weakSelf.accountResult.data.account_name;
        weakSelf.transferService.code = ContractName_VKTIO;
#pragma mark -- [@"data"]
        weakSelf.transferService.binargs = data[@"data"][@"binargs"];
        weakSelf.transferService.pushTransactionType = PushTransactionTypeTransfer;
        weakSelf.transferService.password = weakSelf.loginPasswordView.inputPasswordTF.text;
        [weakSelf.transferService pushTransaction];
    } failure:^(id DAO, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void)pushTransactionDidFinish:(TransactionResult *)result{
    if ([result.code isEqualToNumber:@0 ]) {
        [TOASTVIEW showWithText:NSLocalizedString(@"赎回成功!", nil)];
        [self.navigationController popToRootViewControllerAnimated: YES];
    }else{
        [TOASTVIEW showWithText: result.message];
    }
    [self.loginPasswordView removeFromSuperview];
}


-(void)leftBtnDidClick{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
