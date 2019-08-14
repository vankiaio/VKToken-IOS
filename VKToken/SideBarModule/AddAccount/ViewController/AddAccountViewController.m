//
//  AddAccountViewController.m
//  VKToken
//
//  Created by vankiachain on 2018/7/27.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "AddAccountViewController.h"
#import "AddAccountMainService.h"
#import "AddAccountTableViewCell.h"
#import "ImportAccountViewController.h"
#import "VipRegistAccountViewController.h"
#import "PayRegistAccountViewController.h"
#import "CreateAccountViewController.h"
#import "CheckWhetherHasFreeQuotaResuest.h"
#import "CheckWhetherHasFreeQuotaResult.h"
#import "CommonDialogHasTitleView.h"
#import "CreatePocketViewController.h"
#import "ImportAccountWithoutAccountNameBaseViewController.h"
#import "VKTButton.h"
#import "LanguageSettingViewController.h"
#import "MemonicImportWalletViewController.h"

@interface AddAccountViewController ()<CommonDialogHasTitleViewDelegate, UINavigationControllerDelegate>
@property(nonatomic, strong) NavigationView *navView;
@property(nonatomic , strong) AddAccountMainService *mainService;
@property(nonatomic , strong) CheckWhetherHasFreeQuotaResuest *checkWhetherHasFreeQuotaResuest;
@property(nonatomic , strong) CheckWhetherHasFreeQuotaResult *checkWhetherHasFreeQuotaResult;
@property(nonatomic , strong) CommonDialogHasTitleView *commonDialogHasTitleView;
@end

@implementation AddAccountViewController
{
    UIView  *_mainView;
}

- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_back" title:NSLocalizedString(@"添加账号", nil)rightBtnImgName:@"" delegate:self];
        _navView.leftBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal);
        _navView.lee_theme.LeeConfigBackgroundColor(@"baseAddAccount_background_color");
    }
    return _navView;
}

- (AddAccountMainService *)mainService{
    if (!_mainService) {
        _mainService = [[AddAccountMainService alloc] init];
    }
    return _mainService;
}

- (CheckWhetherHasFreeQuotaResuest *)checkWhetherHasFreeQuotaResuest{
    if (!_checkWhetherHasFreeQuotaResuest) {
        _checkWhetherHasFreeQuotaResuest = [[CheckWhetherHasFreeQuotaResuest alloc] init];
    }
    return _checkWhetherHasFreeQuotaResuest;
}

- (CommonDialogHasTitleView *)commonDialogHasTitleView{
    if (!_commonDialogHasTitleView) {
        _commonDialogHasTitleView = [[CommonDialogHasTitleView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))];
        _commonDialogHasTitleView.delegate = self;
    }
    return _commonDialogHasTitleView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view addSubview:self.navView];
//    [self.view addSubview:self.mainTableView];
//    self.view.lee_theme.LeeConfigBackgroundColor(@"baseAddAccount_background_color");
//    self.mainTableView.lee_theme.LeeConfigBackgroundColor(@"baseAddAccount_background_color");
//    self.mainTableView.frame = CGRectMake(0,0,375,812);

//    [self.view setFrame:CGRectMake(0, -120, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view setBounds:CGRectMake(0, 120, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    UIView *mainView = [UIView new];
    [self.view addSubview:mainView];
    _mainView = mainView;
    
    _mainView.sd_layout
    .leftSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(SCREEN_HEIGHT);
    
    // 创建VKToken BackGround Color
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    gl.startPoint = CGPointMake(0.5, 1);
    gl.endPoint = CGPointMake(0.5, 0);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:180/255.0 green:253/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:91/255.0 green:210/255.0 blue:214/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:1/255.0 green:167/255.0 blue:173/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0),@(0.6f),@(1.0f)];
    [_mainView.layer addSublayer:gl];
    
    
    // 语言button
    UIButton *vktbtnLanguage = [[UIButton alloc] init];
    [_mainView addSubview:vktbtnLanguage];
    vktbtnLanguage.sd_layout
    .topSpaceToView(_mainView, 50)
    .rightSpaceToView(_mainView, 10)
    .heightIs(50)
    .widthIs(100);
    
    NSString *curLanguageText = NSLocalizedString(@"English", nil);
    NSString *curLanguageCode = [DAConfig userLanguage];
    NSLog(@"curLanguage = %@", curLanguageCode);
    if([curLanguageCode hasPrefix:@"en"]){
        curLanguageText = @"English";
    }else if([curLanguageCode hasPrefix:@"zh-Hans"]) {
        curLanguageText = NSLocalizedString(@"中文", nil);
        [DAConfig setUserLanguage:@"zh-Hans"];
    }
    //    vktbtnCreateAccount.frame = CGRectMake(72.5,431,230,50);
    [vktbtnLanguage setTitle: [NSString stringWithFormat: @"%@ >", curLanguageText] forState:(UIControlStateNormal)];
    NSMutableAttributedString *strvktbtnLanguage = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @"%@ >", curLanguageText] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 19], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    vktbtnLanguage.titleLabel.attributedText = strvktbtnLanguage;
    vktbtnLanguage.titleLabel.textAlignment = NSTextAlignmentRight;
    [vktbtnLanguage addTarget:self action:@selector(btnChangeLanguage) forControlEvents:UIControlEventTouchUpInside];
//    [vktbtnLanguage setImage:[UIImage imageNamed:@"icon_arrow"] forState:UIControlStateNormal];
//    [vktbtnLanguage setImageEdgeInsets:UIEdgeInsetsMake(0, 80, 0, -90)];
//
    
    // 创建VKToken ImageView
    UIImageView *imgVKToken = [[UIImageView alloc] init];
    [_mainView addSubview:imgVKToken];
    
    // 加载图片
    imgVKToken.image = [UIImage imageNamed:@"logo_vkt_l"];
    imgVKToken.sd_layout
    .centerXIs(SCREEN_WIDTH/2)
    .topSpaceToView(_mainView, 140)
    .widthIs(imgVKToken.image.size.width/2)
    .heightIs(imgVKToken.image.size.height/2);

    
    // 创建VKToken label
    UILabel *labelVKToken = [[UILabel alloc] init];
    [_mainView addSubview:labelVKToken];
    labelVKToken.sd_layout
    .centerXIs(SCREEN_WIDTH/2)
    .leftSpaceToView(_mainView, 0)
    .rightSpaceToView(_mainView, 0)
    .topSpaceToView(imgVKToken, 12)
    .heightIs(28);
    
    NSMutableAttributedString *strVKToken= [[NSMutableAttributedString alloc] initWithString:@"VKToken" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 22], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    labelVKToken.attributedText = strVKToken;
    labelVKToken.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    labelVKToken.textAlignment = NSTextAlignmentCenter;
    
    // 创建WELCOME label
    UILabel *labelWelcome = [[UILabel alloc] init];
    [_mainView addSubview:labelWelcome];
    labelWelcome.sd_layout
    .centerXIs(SCREEN_WIDTH/2)
    .leftSpaceToView(_mainView, 0)
    .rightSpaceToView(_mainView, 0)
    .topSpaceToView(labelVKToken, 50)
    .heightIs(28);
    
    NSMutableAttributedString *strlabelWelcome= [[NSMutableAttributedString alloc] initWithString:@"Welcome" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 26], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    labelWelcome.attributedText = strlabelWelcome;
    labelWelcome.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    labelWelcome.textAlignment = NSTextAlignmentCenter;
    
    
    // 创建账号button
    VKTButton *vktbtnCreateAccount = [[VKTButton alloc] init];
    [_mainView addSubview:vktbtnCreateAccount];
    vktbtnCreateAccount.sd_layout
    .centerXIs(SCREEN_WIDTH/2 )
    .widthRatioToView(_mainView, 0.6)
    .centerYIs(SCREEN_HEIGHT - 190);
//    vktbtnCreateAccount.frame = CGRectMake(72.5,431,230,50);
    [vktbtnCreateAccount setTitle:NSLocalizedString(@"创建账号", nil) forState:(UIControlStateNormal)];
    NSMutableAttributedString *strvktbtnCreateAccount = [[NSMutableAttributedString alloc] initWithString:@"创建账号" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 19], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    vktbtnCreateAccount.titleLabel.attributedText = strvktbtnCreateAccount;
    [vktbtnCreateAccount addTarget:self action:@selector(btnCreateAccount) forControlEvents:UIControlEventTouchUpInside];
    
    // 恢复button
    VKTButton *vktbtnRecoveryAccount = [[VKTButton alloc] init];
    [_mainView addSubview:vktbtnRecoveryAccount];
    vktbtnRecoveryAccount.sd_layout
    .centerXIs(SCREEN_WIDTH/2 )
    .widthRatioToView(_mainView, 0.6)
    .centerYIs(SCREEN_HEIGHT - 120);
    [vktbtnRecoveryAccount setTitle:NSLocalizedString(@"恢复账号", nil) forState:(UIControlStateNormal)];
    NSMutableAttributedString *strvktbtnRecoveryAccount = [[NSMutableAttributedString alloc] initWithString:@"恢复账号" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 19], NSForegroundColorAttributeName: [UIColor whiteColor]}];
    vktbtnRecoveryAccount.titleLabel.attributedText = strvktbtnRecoveryAccount;
    [vktbtnRecoveryAccount addTarget:self action:@selector(btnRestoreAccount) forControlEvents:UIControlEventTouchUpInside];
    

    [self checkWhetherHasFreeQuota];
//    WS(weakSelf);
//    [self.mainService buildDataSource:^(id service, BOOL isSuccess) {
//        [weakSelf.mainTableView reloadData];
//    }];
}

// 多语言切换
- (void)btnChangeLanguage
{
    NSLog(@"%s", "Click btnChangeLanguage");
    LanguageSettingViewController *vc = [[LanguageSettingViewController alloc] init];
    vc.languageSettingViewControllerFromMode = LanguageSettingViewControllerFromLoginPage;
    [self.navigationController pushViewController:vc animated:YES];
}

// 创建账号
- (void)btnCreateAccount
{
    NSLog(@"%s", "Click btnCreateAccount");
    if (CURRENT_WALLET_HAS_SET_PASSWORD) {
        CreateAccountViewController *vc = [[CreateAccountViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

// 恢复账号
- (void)btnRestoreAccount
{
    NSLog(@"%s", "Click btnRestoreAccount");
//    LanguageSettingViewController *vc = [[LanguageSettingViewController alloc] init];
//    vc.languageSettingViewControllerFromMode = LanguageSettingViewControllerFromLoginPage;
    MemonicImportWalletViewController *_memonicVC = [[MemonicImportWalletViewController alloc] initWithNibName:@"MemonicImportWalletViewController" bundle:nil];
    [self.navigationController pushViewController:_memonicVC animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_REUSEIDENTIFIER];
    if (!cell) {
        cell = [[AddAccountTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CELL_REUSEIDENTIFIER];
    }
    OptionModel *model = self.mainService.dataSourceArray[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90+5+5+20;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mainService.dataSourceArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Wallet *wallet = [[[WalletTableManager walletTable] selectCurrentWallet] firstObject];
    if (wallet && (wallet.wallet_shapwd.length <= 6)) {
        [self addCommonDialogHasTitleView];
        return;
    }
    OptionModel *model = self.mainService.dataSourceArray[indexPath.row];
    if ([model.optionName isEqualToString:NSLocalizedString(@"导入账号", nil)]) {
        ImportAccountWithoutAccountNameBaseViewController *vc = [[ImportAccountWithoutAccountNameBaseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.optionName isEqualToString:NSLocalizedString(@"创建账号", nil)]){
//        PayRegistAccountViewController *vc = [[PayRegistAccountViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
        //VKT for free create
        if (self.checkWhetherHasFreeQuotaResult.data == YES) {
            CreateAccountViewController *vc = [[CreateAccountViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [TOASTVIEW showWithText:self.checkWhetherHasFreeQuotaResult.message];
        }
    }else if ([model.optionName isEqualToString:NSLocalizedString(@"我是VIP", nil)]){
        VipRegistAccountViewController *vc = [[VipRegistAccountViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([model.optionName isEqualToString:NSLocalizedString(@"限时免费", nil)]){
        if (self.checkWhetherHasFreeQuotaResult.data == YES) {
            CreateAccountViewController *vc = [[CreateAccountViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [TOASTVIEW showWithText:self.checkWhetherHasFreeQuotaResult.message];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIButton *btn = [[UIButton alloc] init];
//    [btn setTitle:NSLocalizedString(@"跳过添加", nil) forState:(UIControlStateNormal)];
//    [btn setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
//    btn.font = [UIFont systemFontOfSize:13];
//    [btn setBackgroundColor:[UIColor clearColor]];
//    [btn addTarget:self action:@selector(footerBtnDidClick) forControlEvents:(UIControlEventTouchUpInside)];
//    btn.frame = CGRectMake(0, MARGIN_10, SCREEN_WIDTH, 40);
//    return btn;
    return nil;
}

- (void)footerBtnDidClick{
    if (self.addAccountViewControllerFromMode == AddAccountViewControllerFromLoginPage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (UIView *view in WINDOW.subviews) {
                [view removeFromSuperview];
            }
            [((AppDelegate *)[[UIApplication sharedApplication] delegate]).window setRootViewController: [[BaseTabBarController alloc] init]];
        });
        
    }else if (self.addAccountViewControllerFromMode == AddAccountViewControllerFromOtherPage){
        [self dismissViewControllerAnimated:YES completion:NULL];
        
    }
}

- (void)checkWhetherHasFreeQuota{
    WS(weakSelf);
    [self.checkWhetherHasFreeQuotaResuest getDataSusscess:^(id DAO, id data) {
        CheckWhetherHasFreeQuotaResult *result = [CheckWhetherHasFreeQuotaResult mj_objectWithKeyValues:data];
        weakSelf.checkWhetherHasFreeQuotaResult = result;
    } failure:^(id DAO, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(void)leftBtnDidClick{
    if (self.addAccountViewControllerFromMode == AddAccountViewControllerFromLoginPage) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (self.addAccountViewControllerFromMode == AddAccountViewControllerFromOtherPage){
        [self dismissViewControllerAnimated:YES completion:NULL];
    }

}

//CommonDialogHasTitleViewDelegate
- (void)commonDialogHasTitleViewConfirmBtnDidClick:(UIButton *)sender{
    // 创建钱包(本地数据库)
    CreatePocketViewController *vc = [[CreatePocketViewController alloc] init];
    vc.createPocketViewControllerFromMode = CreatePocketViewControllerFromSocialMode;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)addCommonDialogHasTitleView{
    [self.view addSubview:self.commonDialogHasTitleView];
    
    self.commonDialogHasTitleView.contentTextView.textAlignment = NSTextAlignmentCenter;
    self.commonDialogHasTitleView.comfirmBtnText = NSLocalizedString(@"去设置", nil);
    
    OptionModel *model = [[OptionModel alloc] init];
    model.optionName = NSLocalizedString(@"注意", nil);
    model.detail = NSLocalizedString(@"设置钱包密码继续操作", nil);
    [self.commonDialogHasTitleView setModel:model];
}
@end
