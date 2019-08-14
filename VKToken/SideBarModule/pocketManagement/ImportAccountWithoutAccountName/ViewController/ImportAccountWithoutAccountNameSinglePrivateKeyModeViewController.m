//
//  ImportAccountWithoutAccountNameSinglePrivateKeyModeViewController.m
//  VKToken
//
//  Created by vankiachain on 2018/11/19.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "ImportAccountWithoutAccountNameSinglePrivateKeyModeViewController.h"
#import "ImportAccountWithoutAccountNameSinglePrivateKeyModeHeaderView.h"
#import "Get_account_permission_service.h"
#import "VKT_Key_Encode.h"
#import "BackupVKTAccountService.h"
#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "BackupAccountViewController.h"
#import "ImportAccountWithoutAccountNameService.h"
#import "ImportAccountModel.h"
#import "ImportAccount_AccounsNameDataSourceView.h"
#import "VKToken-Swift.h"



@interface ImportAccountWithoutAccountNameSinglePrivateKeyModeViewController ()<ImportAccountWithoutAccountNameSinglePrivateKeyModeHeaderViewDelegate , LoginPasswordViewDelegate, ImportAccount_AccounsNameDataSourceViewDelegate>

@property(nonatomic , strong) ImportAccountWithoutAccountNameSinglePrivateKeyModeHeaderView *headerView;
@property(nonatomic, strong) LoginPasswordView *loginPasswordView;
@property(nonatomic , strong) Get_account_permission_service *get_account_permission_service;
@property(nonatomic , strong) BackupVKTAccountService *backupVKTAccountService;
@property(nonatomic , strong) ImportAccountWithoutAccountNameService *mainService;
@property(nonatomic , strong) ImportAccount_AccounsNameDataSourceView *importAccount_AccounsNameDataSourceView;
@property(nonatomic , strong) ImportAccountModel *importAccountModel;
@property(nonatomic , strong) NSMutableArray  *finalImportAccountModelArray;
@end

@implementation ImportAccountWithoutAccountNameSinglePrivateKeyModeViewController

{
    // 在本地根据私钥算出的公钥
    NSString *public_key_1_from_local;
    BOOL private_Key_1_is_validate;
    NSString *imported_wallet_id;
}


- (ImportAccountWithoutAccountNameSinglePrivateKeyModeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"ImportAccountWithoutAccountNameSinglePrivateKeyModeHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _headerView.delegate = self;
    }
    return _headerView;
}

- (LoginPasswordView *)loginPasswordView{
    if (!_loginPasswordView) {
        _loginPasswordView = [[[NSBundle mainBundle] loadNibNamed:@"LoginPasswordView" owner:nil options:nil] firstObject];
        _loginPasswordView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        _loginPasswordView.delegate = self;
    }
    return _loginPasswordView;
}

- (BackupVKTAccountService *)backupVKTAccountService{
    if (!_backupVKTAccountService) {
        _backupVKTAccountService = [[BackupVKTAccountService alloc] init];
    }
    return _backupVKTAccountService;
}

- (ImportAccountWithoutAccountNameService *)mainService{
    if (!_mainService) {
        _mainService = [[ImportAccountWithoutAccountNameService alloc] init];
    }
    return _mainService;
}

- (Get_account_permission_service *)get_account_permission_service{
    if (!_get_account_permission_service) {
        _get_account_permission_service = [[Get_account_permission_service alloc] init];
    }
    return _get_account_permission_service;
}

- (ImportAccount_AccounsNameDataSourceView *)importAccount_AccounsNameDataSourceView{
    if (!_importAccount_AccounsNameDataSourceView) {
        _importAccount_AccounsNameDataSourceView = [[ImportAccount_AccounsNameDataSourceView alloc] init];
        _importAccount_AccounsNameDataSourceView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT );
        _importAccount_AccounsNameDataSourceView.delegate = self;
    }
    return _importAccount_AccounsNameDataSourceView;
}

-(NSMutableArray *)finalImportAccountModelArray{
    if (!_finalImportAccountModelArray) {
        _finalImportAccountModelArray = [NSMutableArray array];
    }
    return _finalImportAccountModelArray;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden: YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden: YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headerView];
}



//ImportAccountWithoutAccountNameSinglePrivateKeyModeHeaderViewDelegate
- (void)importAccountWithoutAccountNameSinglePrivateKeyModeHeaderViewConfirmBtnDidClick{
    if (IsStrEmpty(self.headerView.textView.text)) {
        [TOASTVIEW showWithText:NSLocalizedString(@"请保证输入信息的完整~", nil)];
        return;
    }else{
        [WINDOW addSubview:self.loginPasswordView];
    }
    
}

// LoginPasswordViewDelegate
-(void)cancleBtnDidClick:(UIButton *)sender{
    [self removeLoginPasswordView];
}

-(void)confirmBtnDidClick:(UIButton *)sender{
    TokenCoreVKT *tokenCoreVKT = [TokenCoreVKT sharedTokenCoreVKT];
    AccountInfo *model = [[AccountsTableManager accountTable] selectAccountTableWithAccountName: CURRENT_ACCOUNT_NAME];
    // 验证密码输入是否正确
    if([[tokenCoreVKT  verifyWalletPassword:model.account_vktoken_wallet_id :self.loginPasswordView.inputPasswordTF.text:nil]  compare:[NSNumber numberWithInt:0]] == NSOrderedSame) {
        [TOASTVIEW showWithText:NSLocalizedString(@"密码输入错误!", nil)];
        return;
    }
    [SVProgressHUD show];
    
    // 验证 account_name. owner_private_key , active_private_key 是否匹配
    [self validateInputFormat];
}

// 检查输入的格式
- (void)validateInputFormat{
    // 验证私钥格式是否正确
    private_Key_1_is_validate = [VKT_Key_Encode validateWif:self.headerView.textView.text];
    
    if (private_Key_1_is_validate == YES) {
        [self createPublicKeys];
        [self.loginPasswordView removeFromSuperview];
    }else{
        [TOASTVIEW showWithText:NSLocalizedString(@"私钥格式有误!", nil)];
        [self removeLoginPasswordView];
        [SVProgressHUD dismiss];
    }
}

- (void)createPublicKeys{
    // 将用户导入的私钥生成公钥
    public_key_1_from_local = [VKT_Key_Encode vkt_publicKey_with_wif:self.headerView.textView.text];
    [self requestAccountsAccordingPublicKey];
}

- (void)requestAccountsAccordingPublicKey{
    WS(weakSelf);
    self.mainService.public_key = VALIDATE_STRING(public_key_1_from_local);
    [self.mainService get_key_accounts:^(NSArray *importAccountModelArray, BOOL isSuccess) {
        weakSelf.finalImportAccountModelArray = [NSMutableArray arrayWithArray:importAccountModelArray];
        [WINDOW addSubview:weakSelf.importAccount_AccounsNameDataSourceView];
        [weakSelf.importAccount_AccounsNameDataSourceView updateViewWithArray:weakSelf.finalImportAccountModelArray];
    }];
}


//ImportAccount_AccounsNameDataSourceViewDelegate

- (void)importAccount_AccounsNameDataSourceViewConfirmBtnDidClick{
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window setRootViewController: [[BaseTabBarController alloc] init]];
}

- (void)importAccount_AccounsNameDataSourceViewCloseBtnDidClick{}

- (void)importAccount_AccounsNameDataSourceViewTableViewCellDidClick:(ImportAccountModel *)model{
    // should import account
    // 请求该账号的公钥
    WS(weakSelf);
    self.importAccountModel = model;
    self.get_account_permission_service.getAccountRequest.name = VALIDATE_STRING(model.accountName) ;
    [self.get_account_permission_service getAccountPermission:^(id service, BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf configAccountInfo];
        }
    }];
    
}


// config account after import
- (void)configAccountInfo{
    AccountInfo *accountInfo = [[AccountInfo alloc] init];
    accountInfo.account_name = self.importAccountModel.accountName;
    accountInfo.account_img = ACCOUNT_DEFALUT_AVATAR_IMG_URL_STR;
    accountInfo.is_privacy_policy = @"0";
    
    TokenCoreVKT *tokenCoreVKT = [TokenCoreVKT sharedTokenCoreVKT];
    // 验证密码输入是否正确
    [tokenCoreVKT setVktAccountName:imported_wallet_id: self.importAccountModel.accountName];
    
    NSString *privateKey_textView1 = [AESCrypt encrypt:self.headerView.textView.text password:self.loginPasswordView.inputPasswordTF.text];
    
    if ([self.get_account_permission_service.chainAccountOwnerPublicKeyArray containsObject:public_key_1_from_local] && ![self.get_account_permission_service.chainAccountActivePublicKeyArray containsObject:public_key_1_from_local]) {//只owner匹配
        accountInfo.account_owner_public_key = public_key_1_from_local;
        accountInfo.account_owner_private_key = privateKey_textView1;
        accountInfo.account_active_public_key = @"";
        accountInfo.account_active_private_key = @"";
        [self saveAccountWithAccountInfo:accountInfo];
    }else if (![self.get_account_permission_service.chainAccountOwnerPublicKeyArray containsObject:public_key_1_from_local] && [self.get_account_permission_service.chainAccountActivePublicKeyArray containsObject:public_key_1_from_local]){// //只active匹配
        accountInfo.account_owner_public_key = @"";
        accountInfo.account_owner_private_key = @"";
        accountInfo.account_active_public_key = public_key_1_from_local;
        accountInfo.account_active_private_key = privateKey_textView1;
        [self saveAccountWithAccountInfo:accountInfo];
    }else if ([self.get_account_permission_service.chainAccountOwnerPublicKeyArray containsObject:public_key_1_from_local] && [self.get_account_permission_service.chainAccountActivePublicKeyArray containsObject:public_key_1_from_local]){//owner和active全部匹配
        accountInfo.account_owner_public_key = public_key_1_from_local;
        accountInfo.account_owner_private_key = privateKey_textView1;
        accountInfo.account_active_public_key = public_key_1_from_local;
        accountInfo.account_active_private_key = privateKey_textView1;
        [self saveAccountWithAccountInfo:accountInfo];
    }else{//不匹配 导入失败
        [TOASTVIEW showWithText:NSLocalizedString(@"权限错误", nil)];
        for (ImportAccountModel *model in self.finalImportAccountModelArray) {
            if ([model.accountName isEqualToString:self.importAccountModel.accountName]) {
                model.status = 4;
            }
        }
    }
    

    [self.importAccount_AccounsNameDataSourceView updateViewWithArray:self.finalImportAccountModelArray];
}


- (void)saveAccountWithAccountInfo:(AccountInfo *)accountInfo{
    NSMutableArray *tmpArr =[[AccountsTableManager accountTable] selectAccountTable];
    if (tmpArr.count == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:VALIDATE_STRING(accountInfo.account_name)  forKey:Current_Account_name];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    // 助记词找回私钥
    TokenCoreVKT *tokenCoreVKT = [TokenCoreVKT sharedTokenCoreVKT];
    
    NSString *privateKey_textView1 = self.headerView.textView.text;
    
    imported_wallet_id = [tokenCoreVKT importVKTPrivateKey:privateKey_textView1 :public_key_1_from_local :accountInfo.account_name :self.loginPasswordView.inputPasswordTF.text:nil];
    
    [[AccountsTableManager accountTable] addRecord:accountInfo];
//    [WalletUtil setMainAccountWithAccountInfoModel:accountInfo];
    
//    self.backupVKTAccountService.backupVktAccountRequest.uid = CURRENT_WALLET_UID;
//    self.backupVKTAccountService.backupVktAccountRequest.vktAccountName = accountInfo.account_name;
//    [self.backupVKTAccountService backupAccount:^(id service, BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"备份到服务器成功!");
//        }
//    }];
    [TOASTVIEW showWithText:NSLocalizedString(@"导入账号成功!", nil)];
    
    for (ImportAccountModel *model in self.finalImportAccountModelArray) {
        if ([model.accountName isEqualToString:self.importAccountModel.accountName]) {
            model.status = 1;
        }
    }
    
    [self.importAccount_AccounsNameDataSourceView updateViewWithArray:self.finalImportAccountModelArray];
    
}



- (void)removeLoginPasswordView{
    if (self.loginPasswordView) {
        [self.loginPasswordView removeFromSuperview];
        self.loginPasswordView = nil;
    }
}


@end
