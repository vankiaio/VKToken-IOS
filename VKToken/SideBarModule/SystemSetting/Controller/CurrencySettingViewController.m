//
//  CurrencySettingViewController.m
//  VKToken
//
//  Created by vankiachain on 2018/6/8.
//  Copyright © 2018 vankiachain. All rights reserved.
//

#import "CurrencySettingViewController.h"
#import "CurrencySettingService.h"
#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "AddAccountViewController.h"

@interface CurrencySettingViewController ()<NavigationViewDelegate>
@property(nonatomic, strong) NavigationView *navView;
@property(nonatomic , strong) CurrencySettingService *mainService;
@end

@implementation CurrencySettingViewController

- (CurrencySettingService *)mainService{
    if (!_mainService) {
        _mainService = [[CurrencySettingService alloc] init];
    }
    return _mainService;
}

- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_back" title:NSLocalizedString(@"货币单位", nil) rightBtnImgName:@"" delegate:self];
        _navView.leftBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal);

    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.mainTableView];
    WS(weakSelf);
    [self.mainService buildDataSource:^(id service, BOOL isSuccess) {
        [weakSelf.mainTableView reloadData];
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_REUSEIDENTIFIER];
    if (!cell) {
        cell = [[BaseTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CELL_REUSEIDENTIFIER];
    }
    cell.textLabel.text = self.mainService.dataSourceArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mainService.dataSourceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66.5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 设置货币类型
    NSString *selCurrency = self.mainService.dataSourceArray[indexPath.row];
    
    Wallet *wallet = CURRENT_WALLET;
    if (wallet ) {
        NSLog(@"%@", wallet.account_info_table_name);
        // update wallet table
        [[WalletTableManager walletTable] executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET wallet_currency = '%@' WHERE wallet_uid = '%@'", WALLET_TABLE , selCurrency, CURRENT_WALLET_UID]];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [TOASTVIEW showWithText:[NSString stringWithFormat:@"%@ :%@", NSLocalizedString(@"货币单位", nil), selCurrency]];
        
    }
    
}

#pragma mark UITableView + 下拉刷新 隐藏时间 + 上拉加载
#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    WS(weakSelf);
    [self.mainTableView.mj_footer resetNoMoreData];
    [self.mainService buildDataSource:^(NSNumber *dataCount, BOOL isSuccess) {
        if (isSuccess) {
            // 刷新表格
            [weakSelf.mainTableView reloadData];
            if ([dataCount isEqualToNumber:@0]) {
                [weakSelf.mainTableView.mj_header endRefreshing];
                [weakSelf.mainTableView.mj_footer endRefreshing];
                
                [IMAGE_TIP_LABEL_MANAGER showImageAddTipLabelViewWithSocial_Mode_ImageName:@"nomoredata" andBlackbox_Mode_ImageName:@"nomoredata_BB" andTitleStr:NSLocalizedString(@"暂无数据", nil)toView:weakSelf.mainTableView andViewController:weakSelf];
                
            }else{
                // 拿到当前的下拉刷新控件，结束刷新状态
                [weakSelf.mainTableView.mj_header endRefreshing];
                [IMAGE_TIP_LABEL_MANAGER removeImageAndTipLabelViewManager];
            }
        }else{
            [weakSelf.mainTableView.mj_header endRefreshing];
            [weakSelf.mainTableView.mj_footer endRefreshing];
            [IMAGE_TIP_LABEL_MANAGER showImageAddTipLabelViewWithSocial_Mode_ImageName:@"nomoredata" andBlackbox_Mode_ImageName:@"nomoredata_BB" andTitleStr:NSLocalizedString(@"暂无数据", nil)toView:weakSelf.mainTableView andViewController:weakSelf];
        }
    }];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    WS(weakSelf);
    [self.mainService buildNextPageDataSource:^(NSNumber *dataCount, BOOL isSuccess) {
        if (isSuccess) {
            // 刷新表格
            [weakSelf.mainTableView reloadData];
            if ([dataCount isEqualToNumber:@0]) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [weakSelf.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 拿到当前的下拉刷新控件，结束刷新状态
                [weakSelf.mainTableView.mj_footer endRefreshing];
            }
        }else{
            [weakSelf.mainTableView.mj_header endRefreshing];
            [weakSelf.mainTableView.mj_footer endRefreshing];
        }
    }];
}


-(void)leftBtnDidClick{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
