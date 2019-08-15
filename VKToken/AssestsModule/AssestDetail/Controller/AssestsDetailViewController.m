//
//  AssestsDetailViewController.m
//  VKToken
//
//  Created by vankiachain on 2017/11/28.
//  Copyright © 2017年 vankiachain. All rights reserved.
//

#import "AssestsDetailViewController.h"
#import "AssestsDetailHeaderView.h"
#import "NavigationView.h"
#import "TransferNewViewController.h"
#import "RecieveViewController.h"
#import "RedPacketViewController.h"
#import "TendencyChartView.h"
#import "TransactionRecordsService.h"
#import "TransferRecordsTableViewCell.h"
#import "TransactionRecord.h"
#import "GetSparklinesRequest.h"
#import "AssestsShareDetailView.h"
#import "SocialSharePanelView.h"
#import "SocialShareModel.h"
#import "SocialManager.h"
#import "AssestDetailFooterView.h"
#import "TransferModel.h"
#import "TransferRecordsTableViewCell.h"
#import "TransferDetailsViewController.h"
#import "AssestLockRecordsViewController.h"
#import "AssestsDetailHeaderView.h"
#import "AccountManagementViewController.h"
#import "VKToken-swift.h"

@interface AssestsDetailViewController ()< UITableViewDelegate , UITableViewDataSource, NavigationViewDelegate, AssestsDetailHeaderViewDelegate, SocialSharePanelViewDelegate, AssestDetailFooterViewDelegate>
@property(nonatomic, strong) NavigationView *navView;
@property(nonatomic, strong) AssestsDetailHeaderView *headerView;
@property(nonatomic, copy) NSString *currentAccountName;
@property(nonatomic, copy) NSString *currentAssestsType;
@property(nonatomic , copy) NSString *currentContractName;
@property(nonatomic, strong) TransactionRecordsService *transactionRecordsService;
@property(nonatomic , strong) GetSparklinesRequest *getSparklinesRequest;
@property(nonatomic , strong) UIView *shareBaseView;
@property(nonatomic , strong) SocialSharePanelView *socialSharePanelView;
@property(nonatomic , strong) AssestsShareDetailView *assestsShareDetailView;
@property(nonatomic , strong) NSArray *platformNameArr;
@property(nonatomic , strong) AssestDetailFooterView *footerView;
@property(nonatomic , strong) UIImageView *sparklinesImageView;
@property(nonatomic , strong) NSNumber* filterType;
@end

@implementation AssestsDetailViewController

- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT) LeftBtnImgName:@"icon_back" title:self.model.token_symbol rightBtnTitleName:@"···" delegate:self];
        _navView.leftBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal);
        if (LEETHEME_CURRENTTHEME_IS_SOCAIL_MODE) {
            _navView.rightBtn.hidden = NO;
        }else if (LEETHEME_CURRENTTHEME_IS_BLACKBOX_MODE){
            _navView.rightBtn.hidden = NO;
        }
    }
    return _navView;
}

- (AssestsDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"AssestsDetailHeaderView" owner:nil options:nil] firstObject];
        if (kIs_iPhoneX) {
            _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 243+50+25);
        }else{
            _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 243+50);
        }
        
        _headerView.delegate = self;
    }
    return _headerView;
}

- (AssestDetailFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[AssestDetailFooterView alloc] init];
        _footerView.frame = CGRectMake(0, SCREEN_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT);
        _footerView.delegate = self;
    }
    return _footerView;
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
        [cancleBtn addTarget:self action:@selector(cancleShareAssestsDetail) forControlEvents:(UIControlEventTouchUpInside)];
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
- (GetSparklinesRequest *)getSparklinesRequest{
    if (!_getSparklinesRequest) {
        _getSparklinesRequest = [[GetSparklinesRequest alloc] init];
    }
    return _getSparklinesRequest;
}

- (UIImageView *)sparklinesImageView{
    if (!_sparklinesImageView) {
        _sparklinesImageView = [[UIImageView alloc] init];
        _sparklinesImageView.frame = self.headerView.tendencyChartView.bounds;
    }
    return _sparklinesImageView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.navView];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView setTableHeaderView:self.headerView];
    self.mainTableView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT- TABBAR_HEIGHT);
    [self.view addSubview:self.footerView];
    self.currentAccountName = self.accountName;
    self.currentAssestsType = self.model.token_symbol;
    self.currentContractName = self.model.contract_name;
    _filterType = [NSNumber numberWithInteger:0];
    [self requestTransactionHistory];
    [self configHeaderView];
   
}

- (void)requestTransactionHistory{
    if(_filterType.intValue == 0)
    {
        self.transactionRecordsService.getTransactionRecordsRequest.from = self.accountName;
        self.transactionRecordsService.getTransactionRecordsRequest.to = self.accountName;
    }else if(_filterType.intValue == 1){
        self.transactionRecordsService.getTransactionRecordsRequest.from = @"";
        self.transactionRecordsService.getTransactionRecordsRequest.to = self.accountName;
    }else if(_filterType.intValue == 2){
        self.transactionRecordsService.getTransactionRecordsRequest.from = self.accountName;
        self.transactionRecordsService.getTransactionRecordsRequest.to = @"";
    }
    self.transactionRecordsService.getTransactionRecordsRequest.symbols = [NSMutableArray arrayWithObjects:@{@"symbolName":VALIDATE_STRING(self.model.token_symbol)  , @"contractName": VALIDATE_STRING(self.model.contract_name) }, nil];
    [self loadNewData];
}

- (void)configHeaderView{
    //TODO 总额
//    self.headerView.amountLabel.text = [NSString stringWithFormat:@"￥%@", [NumberFormatter displayStringFromNumber:@( self.model.asset_price_cny.doubleValue)]];
//
    self.headerView.amountLabel.text = [NSString stringWithFormat:@"%@ %@", [NumberFormatter displayStringFromNumber:@(self.model.balance.doubleValue)], self.model.token_symbol];
    
    if ([self.model.asset_price_change_in_24h hasPrefix:@"-"]) {
        //        HEXCOLOR(0x1E903C) HEXCOLOR(0xB0B0B0)
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@%%(%@)", self.model.asset_price_change_in_24h, NSLocalizedString(@"今日", nil)]];
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:HEXCOLOR(0xB51515)
                           range:NSMakeRange(0, self.model.asset_price_change_in_24h.length + 1)];
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:HEXCOLOR(0xB51515)
                           range:NSMakeRange(self.model.asset_price_change_in_24h.length+1, 4)];
        self.headerView.fluctuateLabel.attributedText = attrString;
    }else{
        //B51515
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"+%@%%(%@)", self.model.asset_price_change_in_24h , NSLocalizedString(@"今日", nil)]];
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:HEXCOLOR(0x1E903C)
                           range:NSMakeRange(0, self.model.asset_price_change_in_24h.length + 2)];
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:HEXCOLOR(0x1E903C)
                           range:NSMakeRange(self.model.asset_price_change_in_24h.length + 2, 4)];
        
        self.headerView.fluctuateLabel.attributedText = attrString;
    }
    //todo 锁仓
    if (self.model.locked_amount.integerValue == 0 ) {
        self.headerView.lockedLabel.text = NSLocalizedString(@"暂无锁仓", nil);
    }else{
        self.headerView.lockedLabel.text = [NSString stringWithFormat:@"%@:%@ %@", NSLocalizedString(@"锁仓", nil), [NumberFormatter displayStringFromNumber:@(self.model.locked_amount.doubleValue)],self.model.token_symbol];
    }
    self.headerView.accountLabel.text = self.accountName;
    
    self.headerView.Assest_balance_Label.text = [NSString stringWithFormat:@"%@:%@ %@", NSLocalizedString(@"余额", nil), [NumberFormatter displayStringFromNumber:@(self.model.balance.doubleValue-self.model.locked_amount.doubleValue)], self.model.token_symbol];
    
//    self.headerView.assest_value_label.text = [NSString stringWithFormat:@"≈%@ CNY", [NumberFormatter displayStringFromNumber:@(self.model.balance.doubleValue * self.model.asset_price_cny.doubleValue)]];
    
    WS(weakSelf);
    [self.getSparklinesRequest getDataSusscess:^(id DAO, id data) {
        NSString *tendencyUrlStr ;
        if ([weakSelf.model.token_symbol isEqualToString:@"VKT"] && [weakSelf.model.contract_name isEqualToString:ContractName_VKTIOTOKEN]) {
            tendencyUrlStr = data[@"data"][@"sparkline_vkt_png"];
        }else if ([weakSelf.model.token_symbol isEqualToString:@"OCT"] && [weakSelf.model.contract_name isEqualToString:ContractName_OCTOTHEMOON]){
            tendencyUrlStr = data[@"data"][@"sparkline_oct_png"];
        }
        if (!IsNilOrNull(weakSelf.sparklinesImageView)) {
            [weakSelf.sparklinesImageView removeFromSuperview];
        }
        [weakSelf.headerView.tendencyChartView addSubview:weakSelf.sparklinesImageView];
        [weakSelf.sparklinesImageView sd_setImageWithURL:String_To_URL(tendencyUrlStr) placeholderImage:[UIImage imageNamed:@"assestsSparkLinePlaceholder"] options:(SDWebImageCacheMemoryOnly)];
    } failure:^(id DAO, NSError *error) {
        NSLog(@"%@", error);
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TransferRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_REUSEIDENTIFIER];
    if (!cell) {
        cell = [[TransferRecordsTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CELL_REUSEIDENTIFIER];
    }
    TransactionRecord *model = self.transactionRecordsService.dataSourceArray[indexPath.row];
    model = self.transactionRecordsService.dataSourceArray[indexPath.row];
    cell.currentAccountName = self.currentAccountName;
    cell.model = model;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.transactionRecordsService.dataSourceArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TransactionRecord *model = self.transactionRecordsService.dataSourceArray[indexPath.row];
    TransferDetailsViewController *vc = [[TransferDetailsViewController alloc] init];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

- (void)leftBtnDidClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnDidClick {
    WS(weakSelf);
    AccountInfo *model;
    model = [[AccountsTableManager accountTable] selectAccountTableWithAccountName:self.accountName];
    AccountManagementViewController *vc = [[AccountManagementViewController alloc] init];
    vc.model = model;
    [weakSelf.navigationController pushViewController:vc animated:YES];
}

- (void)dismiss{
    [self.shareBaseView removeFromSuperview];
}

- (void)cancleShareAssestsDetail{
    [self.shareBaseView removeFromSuperview];
}

// SocialSharePanelViewDelegate
- (void)SocialSharePanelViewDidTap:(UITapGestureRecognizer *)sender{
    NSString *platformName = self.platformNameArr[sender.view.tag-1000];
    ShareModel *model = [[ShareModel alloc] init];
    if ([self.model.token_symbol isEqualToString:@"VKT"]) {
        model.imageName = @"vkt_avatar";
    }else if ([self.model.token_symbol isEqualToString:@"OCT"]){
        model.imageName = @"oct_avatar";
    }else{
        model.imageName = @"logo_bg_blue";
    }
    model.title = [NSString stringWithFormat:@"%@%@",self.model.token_symbol, NSLocalizedString(@"最新咨询详情", nil)];
    
    NSString *priceChange ;
    if ([self.model.asset_price_change_in_24h hasPrefix:@"-"]) {
        priceChange = [NSString stringWithFormat:@"%@%%", self.model.asset_price_change_in_24h];
    }else{
        priceChange = [NSString stringWithFormat:@"+%@%%", self.model.asset_price_change_in_24h];
    }
    model.detailDescription = [NSString stringWithFormat:@"%@%@\n%@%@\n%@¥%@\n", NSLocalizedString(@"参考价格", nil),[NSString stringWithFormat:@"¥%@", [NumberFormatter displayStringFromNumber:@(self.model.asset_price_cny.doubleValue)]], NSLocalizedString(@"24小时涨跌幅", nil), priceChange,NSLocalizedString(@"总市值", nil), [NumberFormatter displayStringFromNumber:@(self.model.asset_market_cap_cny.doubleValue)]];
    model.webPageUrl = @"https://VKToken.com";
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

//AssestDetailFooterViewDelegate
- (void)assestsDetailFooterViewDidClick:(UIButton *)sender{
    if (sender.tag == 1000) {
        TransferNewViewController *vc = [[TransferNewViewController alloc] init];
        vc.currentAssestsType = self.currentAssestsType;
        vc.get_token_info_service_data_array = self.get_token_info_service_data_array;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1001){
        RecieveViewController *vc = [[RecieveViewController alloc] init];
        TransferModel *model = [[TransferModel alloc] init];
        model.account_name = self.accountName;
        model.coin = self.currentAssestsType;
        vc.transferModel = model;
        vc.get_token_info_service_data_array = self.get_token_info_service_data_array;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1002){
        if ([self.model.token_symbol isEqualToString:@"OCT"]  || [self.model.token_symbol isEqualToString:@"VKT"]) {
            RedPacketViewController *vc = [[RedPacketViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [TOASTVIEW showWithText:NSLocalizedString(@"暂不支持该TOKEN红包", nil)];
        }
    }
}

- (void)assetsLocksBtnDidClick:(UIButton *)sender{
    AssestLockRecordsViewController *vc = [[AssestLockRecordsViewController alloc] init];
    vc.currentAccountName = self.accountName;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)copyAccountBtnDidClick:(UIButton *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =VALIDATE_STRING(self.model.account_name);
    [TOASTVIEW showWithText:NSLocalizedString(@"复制成功", nil)];
}

// 筛选转账列表
- (void)transferClassTabBarDidClick:(UITabBarItem *)sender{
//        NSString* msg = [NSString stringWithFormat:@"您选中第【%d】项"
//                         , sender.tag];
//        // 创建、并显示一个UIAlertView控件
//        UIAlertView* alert = [[UIAlertView alloc]
//                              initWithTitle:@"提示"
//                              message:msg
//                              delegate:nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles: nil];
//        [alert show];
    _filterType = [NSNumber numberWithInteger:sender.tag];
    [self requestTransactionHistory];
}

#pragma mark UITableView + 下拉刷新 隐藏时间 + 上拉加载
#pragma mark - 数据处理相关
#pragma mark 下拉刷新数据
- (void)loadNewData
{
    WS(weakSelf);
    [self.mainTableView.mj_footer resetNoMoreData];
    [self.transactionRecordsService buildDataSource:^(NSNumber *dataCount, BOOL isSuccess) {
        if (isSuccess) {
            // 刷新表格
            [weakSelf.mainTableView reloadData];
            if ([dataCount isEqualToNumber:@0]) {
                // 拿到当前的上拉刷新控件，变为没有更多数据的状态
                [weakSelf.mainTableView.mj_header endRefreshing];
                [weakSelf.mainTableView.mj_footer endRefreshing];
                [weakSelf.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                // 拿到当前的下拉刷新控件，结束刷新状态
                [weakSelf.mainTableView.mj_header endRefreshing];
            }
        }else{
            [weakSelf.mainTableView.mj_header endRefreshing];
            [weakSelf.mainTableView.mj_footer endRefreshing];
            [weakSelf.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }
    }];
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    WS(weakSelf);
    [self.transactionRecordsService buildNextPageDataSource:^(NSNumber *dataCount, BOOL isSuccess) {
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

@end
