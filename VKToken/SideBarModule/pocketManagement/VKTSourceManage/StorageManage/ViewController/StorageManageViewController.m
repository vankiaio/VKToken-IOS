//
//  StorageManageViewController.m
//  VKToken
//
//  Created by 师巍巍 on 21/06/2018.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "StorageManageViewController.h"
#import "StorageManageHeaderView.h"
#import "ModifyApproveViewController.h"
#import "TradeRamViewController.h"
#import "VKTResourceService.h"

NSString * const TradeRamDidSuccessNotification = @"TradeRamDidSuccessNotification";

@interface StorageManageViewController ()<StorageManageHeaderViewDelegate>
@property(nonatomic , strong) StorageManageHeaderView *headerView;
@property(nonatomic , strong) VKTResourceResult *vktResourceResult;
@property(nonatomic , strong) VKTResourceService *vktResourceService;

@end

@implementation StorageManageViewController

- (StorageManageHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"StorageManageHeaderView" owner:nil options:nil] firstObject];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 320);
        _headerView.delegate = self;
    }
    return _headerView;
}
- (VKTResourceResult *)vktResourceResult{
    if (!_vktResourceResult) {
        _vktResourceResult = [[VKTResourceResult alloc] init];
    }
    return _vktResourceResult;
}
- (VKTResourceService *)vktResourceService{
    if (!_vktResourceService) {
        _vktResourceService = [[VKTResourceService alloc] init];
    }
    return _vktResourceService;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self buildDataSource];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    self.view.lee_theme
    .LeeConfigBackgroundColor(@"baseHeaderView_background_color");
    [self buildDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tradeRamDidFinish) name:TradeRamDidSuccessNotification object:nil];
}

- (void)buildDataSource{
    WS(weakSelf);
    self.vktResourceService.getAccountRequest.name = self.accountResult.data.account_name;
    [self.vktResourceService get_account:^(VKTResourceResult *result, BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.vktResourceResult = result;
            CGFloat progress = weakSelf.vktResourceResult.data.ram_usage.doubleValue/weakSelf.vktResourceResult.data.ram_max.doubleValue;
            weakSelf.headerView.progressView.progress = progress;
            weakSelf.headerView.tipLabel.text = [NSString stringWithFormat:@"%@(%@byte/%@byte)", NSLocalizedString(@"存储配额使用情况", nil), weakSelf.vktResourceResult.data.ram_usage, weakSelf.vktResourceResult.data.ram_max];
        }
    }];
}


//StorageManageHeaderViewDelegate
-(void)buyRamBtnDidClick:(UIButton *)sender{
    TradeRamViewController *vc = [[TradeRamViewController alloc] init];
    vc.pageType = @"buy_ram";
    vc.vktResourceResult = self.vktResourceResult;
    vc.accountResult = self.accountResult;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)sellRamBtnDidClick:(UIButton *)sender{
    TradeRamViewController *vc = [[TradeRamViewController alloc] init];
    vc.pageType = @"sell_ram";
    vc.vktResourceResult = self.vktResourceResult;
    vc.accountResult = self.accountResult;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tradeRamDidFinish{
    [self buildDataSource];
}

@end
