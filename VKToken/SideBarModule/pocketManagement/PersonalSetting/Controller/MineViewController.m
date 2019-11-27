//
//  MineViewController.m
//  VKToken
//
//  Created by Lee on 2019/7/9.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineViewController.h"
#import "Macro.h"
#import <Masonry/Masonry.h>
#import "SystemSettingViewController.h"
#import "ContactTableViewController.h"
#import "AboutUsViewController.h"
//#import "MessageFeedbackViewController.h"
//#import "MessageCenterViewController.h"
#import "FeedbackViewController.h"
#import "InvitationCoreViewController.h"
#import "MineHeaderView.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *tableSources;
@property (nonatomic, strong) MineHeaderView *mineHeaderView;
@end

@implementation MineViewController

- (MineHeaderView *) mineHeaderView{
    if (!_mineHeaderView) {
        _mineHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:nil options:nil] firstObject];
        _mineHeaderView.frame = self.view.bounds;
//        _mineHeaderView.delegate = self;
    }
    return _mineHeaderView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    [self.view addSubview:self.mineHeaderView];
    [self setupData];
    [self setupSubviews];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavigationBarColor];
}

- (void)changeLanguage {
    [self setupData];
    [self.table reloadData];
}

- (void)viewDidReceiveLocalizedNotification {
//    [super viewDidReceiveLocalizedNotification];
}


#pragma mark - Private

- (void)setupData {
    self.tableSources = @[@[],
                        @[@{@"icon":@"icon_me_acc",@"title":NSLocalizedString(@"账号本",nil),@"action":@"pushToAccountbook"},
                          @{@"icon":@"icon_me_msg",@"title":NSLocalizedString(@"消息",nil),@"action":@"pushToMessage"}],
                        @[@{@"icon":@"icon_me_setting",@"title":NSLocalizedString(@"设置",nil),@"action":@"pushToSetting"},
                          @{@"icon":@"icon_me_tk",@"title":NSLocalizedString(@"使用条款",nil),@"action":@"pushToTermsOfUse"},
                          @{@"icon":@"icon_me_feedback",@"title":NSLocalizedString(@"意见反馈",nil),@"action":@"pushToFeedback"},
                          @{@"icon":@"icon_me_about",@"title":NSLocalizedString(@"关于我们",nil),@"action":@"pushToAboutUs"},
                          @{@"icon":@"icon_me_share",@"title":NSLocalizedString(@"邀请码",nil),@"action":@"pushToInvitationCode"}]
                          ];
}

- (void)setupSubviews {
    [self.mineHeaderView addSubview:self.table];
}

- (void)setupConstraints {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.mineHeaderView);
        make.top.equalTo(self.mineHeaderView).with.offset(220);
    }];
}

- (void)setNavigationBarColor {
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableSources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *infos = self.tableSources[section];
    if (infos) {
        return infos.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const mineCellId = @"mineCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineCellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellId];
    }
    NSDictionary *dict = self.tableSources[indexPath.section][indexPath.row];
    if (dict) {
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor colorWithRGBHex:0x323334];
        cell.textLabel.text = [dict objectForKey:@"title"];
        cell.imageView.image = [UIImage imageNamed:[dict objectForKey:@"icon"]];
        CGSize imageSize = CGSizeMake(32, 32);
        //调整image的大小
        UIGraphicsBeginImageContextWithOptions(imageSize, NO,0.0);
        CGRect imageRect=CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 0 : 12;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 12)];
    view.backgroundColor = [UIColor colorWithRGBHex:0xf5f5f9];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *info = self.tableSources[indexPath.section][indexPath.row];
    NSString *action = info[@"action"];
    if (action) {
        SEL selector = NSSelectorFromString(action);
        [self performSelector:selector withObject:nil];
    }
}
#pragma mark - push

- (void)pushToAccountbook {
    ContactTableViewController *vc = [[ContactTableViewController alloc] init];
    [self cw_pushViewController:vc];}

- (void)pushToMessage {
//    MessageCenterViewController *vc = [[MessageCenterViewController alloc] init];
//    [self cw_pushViewController:vc];
}

- (void)pushToSetting {
    SystemSettingViewController *vc = [[SystemSettingViewController alloc ] init];
    [self cw_pushViewController:vc];
}

- (void)pushToAboutUs {
    AboutUsViewController *vc = [[AboutUsViewController alloc] init];
    [self cw_pushViewController:vc];
}
- (void)pushToFeedback {
//    MessageFeedbackViewController *vc = [[MessageFeedbackViewController alloc] init];
//    [self cw_pushViewController:vc];
    FeedbackViewController *vc = [[FeedbackViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pushToTermsOfUse {
    RtfBrowserViewController *vc = [[RtfBrowserViewController alloc] init];
    vc.rtfFileName = @"VKTokenPrivacyPolicy";
    [self cw_pushViewController:vc];
}

- (void)pushToInvitationCode {
    InvitationCoreViewController *vc = [[InvitationCoreViewController alloc] init];
    [self cw_pushViewController:vc];
}

#pragma mark - Getter & Setter
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableFooterView = [UIView new];
        _table.backgroundColor = [UIColor colorWithRGBHex:0xf5f5f9];
        _table.separatorInset = UIEdgeInsetsMake(0, 20, 0, 0);
    }
    return _table;
}

@end
