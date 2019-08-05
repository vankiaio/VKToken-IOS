//
//  MemonicImportWalletViewController.m
//  VKToken
//
//  Created by Lee on 06/02/2019.
//  Copyright © 2018 Lee. All rights reserved.
//

#import "MemonicImportWalletViewController.h"
#import "RetrivePathCell.h"
#import "UIImage+.h"
#import "Macro.h"
#import "NJOPasswordStrengthEvaluator.h"
#import "PasswordView.h"
#import "Get_key_accounts_request.h"
#import "VKTMappingResult.h"
#import "VKT_Key_Encode.h"
#import "VKToken-swift.h"


//@import Toast;
//@import SVProgressHUD;

@interface MemonicImportWalletViewController ()<UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *memonicBg;
@property (weak, nonatomic) IBOutlet UITextView *memonicTextview;
@property (weak, nonatomic) IBOutlet UILabel *memonicPlaceholder;
@property (weak, nonatomic) IBOutlet UILabel *chainNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *pathTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextfield;
@property (weak, nonatomic) IBOutlet UITextField *pwdConfirmTextfield;
@property (weak, nonatomic) IBOutlet UITextField *hintTextfield;
@property (weak, nonatomic) IBOutlet UIButton *confirmProtocolButton;
@property (weak, nonatomic) IBOutlet UIButton *protocolDetailButton;
@property (weak, nonatomic) IBOutlet UIButton *startImportButton;
@property (weak, nonatomic) IBOutlet UIButton *chainTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *pathButton;
@property (weak, nonatomic) IBOutlet UITableView *pathTable;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pathTableHeightContraints;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSArray *paths;

//@property (nonatomic, strong) WalletDao *walletDao;

//localized
@property (weak, nonatomic) IBOutlet UILabel *foundataionLabel;
@property (weak, nonatomic) IBOutlet UILabel *pathLabel;
@property (weak, nonatomic) IBOutlet UILabel *pwdLabel;
@property (weak, nonatomic) IBOutlet UILabel *repeatLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UILabel *pwdStrengthLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NavigationView *navView;
@property (nonatomic, assign) BOOL importing;

@end

@implementation MemonicImportWalletViewController

- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_back" title:NSLocalizedString(@"恢复账号", nil)rightBtnTitleName:@"" delegate:self];
        _navView.leftBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal);
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    [self setupData];
    [self setupSubviews];
}

- (void)changeLanguage {
    self.memonicPlaceholder.text = NSLocalizedString(@"input_mnemonic_words", nil);
    self.foundataionLabel.text = NSLocalizedString(@"wallet_foundation", nil);
    self.pathLabel.text = NSLocalizedString(@"derive_path", nil);
    self.pwdLabel.text = NSLocalizedString(@"set_pwd", nil);
    self.repeatLabel.text = NSLocalizedString(@"repeat_pwd", nil);
    self.hintLabel.text = NSLocalizedString(@"pwd_hint", nil);
    [self.confirmProtocolButton setTitle:NSLocalizedString(@"read_agree", nil) forState:UIControlStateNormal];
    [self.protocolDetailButton setTitle:NSLocalizedString(@"service_privacy", nil) forState:UIControlStateNormal];
    self.hintTextfield.placeholder = NSLocalizedString(@"pwd_optional", nil);
    [self.startImportButton setTitle:NSLocalizedString(@"import_start", nil) forState:UIControlStateNormal];
    self.hintTextfield.placeholder = NSLocalizedString(@"pwd_optional", nil);
    self.titleLabel.text = NSLocalizedString(@"recovery_account", nil);
}

- (void)responseLeftButton {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setupData {
    NSString *selfPath = [NSString stringWithFormat:@"m/44'/60'/1'/0/0 %@",NSLocalizedString(@"custom_path", nil)];
    
    self.paths = @[@"m/44'/60'/0'/0 Ledger (ETH)",
                   @"m/44'/60'/0'/0/0 Jaxx,Metamask (ETH)",
                   selfPath];
}

- (void)setupSubviews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.memonicBg.layer.borderWidth = 0.5;
    self.memonicBg.layer.borderColor = [UIColor colorWithRGBHex:0xd8d8d8].CGColor;
    self.memonicBg.layer.cornerRadius = 2;
    self.memonicBg.layer.masksToBounds = YES;
    self.memonicTextview.delegate = self;
    
    self.pathTextfield.enabled = NO;
    self.pathTextfield.text = [self.paths objectAtIndex:1];
    
    self.selectedIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    self.pathTable.layer.shadowOpacity = 0.1;
    self.pathTable.layer.shadowRadius = 4;
    self.pathTable.layer.shadowColor = [UIColor colorWithRGBHex:0x333333].CGColor;
    self.pathTable.layer.borderWidth = 0.5;
    self.pathTable.layer.borderColor = [UIColor colorWithRGBHex:0xd8d8d8].CGColor;
    [self.pathTable registerNib:[UINib nibWithNibName:@"RetrivePathCell" bundle:nil] forCellReuseIdentifier:@"RetrivePathCell"];
    self.pathTable.hidden = YES;
    
    [self.startImportButton setBackgroundImage:[UIImage tb_imageWithColor:[UIColor colorWithRGBHex:0x08B2B8] andSize:CGSizeMake(kScreenWidth, 47)] forState:UIControlStateNormal];
    self.startImportButton.layer.cornerRadius = 4;
    self.startImportButton.layer.masksToBounds = YES;
    self.startImportButton.enabled = NO;
    
    [self.pwdTextfield addTarget:self action:@selector(textFiledDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.pwdConfirmTextfield addTarget:self action:@selector(textFiledDidChanged:) forControlEvents:UIControlEventEditingChanged];
    self.pwdTextfield.delegate = self;
    
//    if (self.blockchain) {
//        self.chainNameLabel.text = self.blockchain.desc;
        self.chainNameLabel.text = @"self.blockchain.desc";
//    }
}

// NavigationViewDelegate
-(void)leftBtnDidClick{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)checkStartButtonStatus {
    BOOL enable = YES;
    if (self.memonicTextview.text.length <= 0) {
        enable = NO;
    }
    if (self.pwdTextfield.text.length < 8) {
        enable = NO;
    }
    if (self.pwdConfirmTextfield.text.length < 8) {
        enable = NO;
    }
//    if (!self.confirmProtocolButton.isSelected) {
//        enable = NO;
//    }
    
    if (_importing) {
        enable = NO;
    }
    
    self.startImportButton.enabled = enable;
}

#pragma mark - UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RetrivePathCell *cell = (RetrivePathCell *)[tableView dequeueReusableCellWithIdentifier:@"RetrivePathCell" forIndexPath:indexPath];
    cell.pathLabel.text = [self.paths objectAtIndex:indexPath.row];
    BOOL selected = indexPath.row == self.selectedIndexPath.row;
    cell.checkIcon.hidden = !selected;
    cell.pathLabel.textColor = [UIColor colorWithRGBHex:selected?0x2890FE:0x333333];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectedIndexPath = indexPath;
    self.pathTable.hidden = YES;
    self.pathTextfield.enabled = indexPath.row == 2;
    if (indexPath.row == 2) {
        self.pathTextfield.text = @"m/44'/60'/1'/0/0";
    } else {
        self.pathTextfield.text = [self.paths objectAtIndex:indexPath.row];
    }
}

#pragma mark - ButtonEvents

- (IBAction)onChainTypeButtonTapped:(id)sender {
    Log(@"TODO : 进入区块体系选择");
}

- (IBAction)onPathButtonTapped:(id)sender {
    
    if (self.pathTable.hidden) {
        self.pathTable.hidden = NO;
        [self.pathTable reloadData];
    } else {
        self.pathTable.hidden = YES;
    }
}

- (IBAction)onConfirmProtocolButtonTapped:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    [self checkStartButtonStatus];
}

- (IBAction)onProtocolButtonTapped:(id)sender {
//    H5ViewController *h5VC = [[H5ViewController alloc] init];
////    h5VC.urlString = @"http://tokenpocket.skyfromwell.com/terms/index.html";
//    h5VC.viewType = kH5ViewTypeTerms;
//    h5VC.titleString = [[LocalizedHelper standardHelper] stringWithKey:@"service_privacy"];
//    [self.navigationController pushViewController:h5VC animated:YES];
}

- (IBAction)onStartImportButtonTapped:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    if (weakSelf.importing) {
        return;
    }
    
    if (!self.confirmProtocolButton.isSelected) {
        [TOASTVIEW showWithText:NSLocalizedString(@"read_first", nil)];
        return;
    }
    
    NSString *mnemonicWords = self.memonicTextview.text;
    NSArray *words = [mnemonicWords componentsSeparatedByString:@" "];
    if (words.count < 12) {
        [TOASTVIEW showWithText:NSLocalizedString(@"illegal_mnem", nil)];
        return;
    }
    
    if (![self.pwdTextfield.text isEqualToString:self.pwdConfirmTextfield.text]) {
        [TOASTVIEW showWithText:NSLocalizedString(@"pwd_not_match", nil)];
        return;
    }

    weakSelf.importing = YES;
    [self checkStartButtonStatus];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"importing", nil)];
    NSString *password = self.pwdTextfield.text;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 助记词找回私钥
        TokenCoreVKT *tokenCoreVKT = [TokenCoreVKT sharedTokenCoreVKT];
        NSString * mnemonicStr = [tokenCoreVKT generateIdentity: mnemonicWords: password:nil];
        NSLog(NSLocalizedString(@"generateIdentity助记词:%@", nil), tokenCoreVKT.requestResult);
        
//        [tokenCoreVKT deriveEosWallet:password];
        NSString *imported_wallet_id = [tokenCoreVKT importVKTMnemonic:mnemonicStr : @"" :password:nil];
        NSLog(NSLocalizedString(@"deriveEosWallet助记词:%@", nil), tokenCoreVKT.requestResult);
        
        NSString *privateKeyStr = [NSString stringWithFormat:@"%@", [tokenCoreVKT getVktPrivateKey: password:nil]];
        
        Get_key_accounts_request *get_key_accounts_request = [[Get_key_accounts_request alloc] init];
        get_key_accounts_request.public_key = [VKT_Key_Encode vkt_publicKey_with_wif:privateKeyStr];
        [get_key_accounts_request postOuterDataSuccess:^(id DAO, id data) {
            
            VKTMappingResult *result = [VKTMappingResult mj_objectWithKeyValues:data];
            if ([result.code isEqualToNumber:@0]) {
                
                if (result.account_names.count > 0) {
                    
                    Wallet *wallet = CURRENT_WALLET;
                    if(!wallet) {
                        // 如果本地没有钱包
                        Wallet *model = [[Wallet alloc] init];
                        //    model.wallet_name = self.createWalletView.walletNameTF.text;
                        model.wallet_name = @"VKToken";
                        
                        model.wallet_shapwd = [WalletUtil generate_wallet_shapwd_withPassword:password];
                        model.wallet_uid = [model.wallet_name sha256];
                        model.account_info_table_name = [NSString stringWithFormat:@"%@_%@", ACCOUNTS_TABLE,model.wallet_uid];
                        [[WalletTableManager walletTable] addRecord: model];
                        [[NSUserDefaults standardUserDefaults] setObject: model.wallet_uid  forKey:Current_wallet_uid];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                    // TokenCoreVKT添加账户
                    [tokenCoreVKT setVktAccountName:result.account_names[0]];
                    // 本地公钥和网络公钥匹配, 允许进行导入本地操作
                    AccountInfo *accountInfo = [[AccountInfo alloc] init];
                    accountInfo.account_name = result.account_names[0];
                    accountInfo.account_img = ACCOUNT_DEFALUT_AVATAR_IMG_URL_STR;
                    accountInfo.account_active_public_key = get_key_accounts_request.public_key;
                    accountInfo.account_owner_public_key = get_key_accounts_request.public_key;
                    accountInfo.account_active_private_key = [AESCrypt encrypt:privateKeyStr password:password];
                    accountInfo.account_owner_private_key = accountInfo.account_active_private_key;
                    accountInfo.is_privacy_policy = @"0";
                    [[AccountsTableManager accountTable] addRecord:accountInfo];
                    [WalletUtil setMainAccountWithAccountInfoModel:accountInfo];
                    
                    [TOASTVIEW showWithText:NSLocalizedString(@"账号导入成功!", nil)];
                    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window setRootViewController: [[BaseTabBarController alloc] init]];
                    [TOASTVIEW showWithText:NSLocalizedString(@"账号导入成功!", nil)];
                    [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window setRootViewController: [[BaseTabBarController alloc] init]];
                }
                
            }else{
                [TOASTVIEW showWithText:NSLocalizedString(@"未查到对应账号!",nil)];
            }
        } failure:^(id DAO, NSError *error) {
            NSLog(@"%@", error);
        }];
        
        weakSelf.importing = NO;
        [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"import_succ", nil)];
        [weakSelf responseLeftButton];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.memonicPlaceholder.hidden = textView.text.length > 0;
    [self checkStartButtonStatus];
}

- (void)textFiledDidChanged:(UITextField *)textfield {
    [self checkStartButtonStatus];
    if ([self.pwdTextfield isEqual:textfield]) {
        [self showPasswordTipLabelWithField:textfield];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.pwdTextfield isEqual:textField]) {
        [self showPasswordTipLabelWithField:textField];
    }
}

- (void)showPasswordTipLabelWithField:(UITextField *)textField {
    if (textField.text.length == 0) {
        self.pwdStrengthLabel.text = NSLocalizedString(@"pwd_length_tip", nil);
    } else {
        if ([self judgePasswordStrength:textField.text] == eWeakPassword) {
            self.pwdStrengthLabel.text = NSLocalizedString(@"pwd_length_weak", nil);
        } else {
            self.pwdStrengthLabel.text = @"";
        }
    }
}

#pragma mark - Setter
- (void)setScanResult:(NSString *)scanResult {
    _scanResult = scanResult;
    self.memonicTextview.text = scanResult;
    if (scanResult.length > 0) {
        self.memonicPlaceholder.hidden = YES;
    }
}

//- (WalletDao *)walletDao {
//    if (!_walletDao) {
//        _walletDao = [WalletDao new];
//    }
//    return _walletDao;
//}

#pragma mark - TODO
- (PasswordEnum)judgePasswordStrength:(NSString*)password {
    
    if (password.length == 0) {
        return eEmptyPassword;
    }
    
    NJOPasswordStrength strength = [NJOPasswordStrengthEvaluator strengthOfPassword:password];
    
    PasswordEnum pwdStrong = eWeakPassword;
    switch (strength) {
        case NJOVeryWeakPasswordStrength:
        case NJOWeakPasswordStrength:
            pwdStrong = eWeakPassword;
            break;
        case NJOReasonablePasswordStrength:
            pwdStrong = eSosoPassword;
            break;
        case NJOStrongPasswordStrength:
            pwdStrong = eGoodPassword;
            break;
        case NJOVeryStrongPasswordStrength:
            pwdStrong = eSafePassword;
            break;
        default:
            break;
    }
    
    return pwdStrong;
}

@end
