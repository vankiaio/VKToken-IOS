//
//  AddViewController.m
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AddViewController.h"
#import "AddContactCell.h"
#import "NavigationView.h"

@import Masonry;
@import Toast;

@interface AddViewController ()<UIGestureRecognizerDelegate, NavigationViewDelegate,UITableViewDelegate,UITableViewDataSource,AddContactCellDelegate>

@property (nonatomic, strong) NavigationView *navView;
@property (nonatomic,retain) UIAlertView *alertView;
@property (nonatomic, strong) NSArray<NSMutableDictionary *> *dataList;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation AddViewController

- (NavigationView *)navView{
    if (!_navView) {
        _navView = [NavigationView navigationViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NAVIGATIONBAR_HEIGHT*0.75) LeftBtnImgName:@"icon_back" title:NSLocalizedString(@"新建联系人", nil)rightBtnTitleName:@"" delegate:self];
        _navView.leftBtn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal);
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.view addSubview:self.navView];
    //创建视图
    [self setupSubviews];

    //设置手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
}

//  NavigationViewDelegate
-(void)leftBtnDidClick{
    [self cancel:nil];
}

#pragma mark - 点击屏幕回收键盘
- (void)tapClick:(UITapGestureRecognizer *)sender{
    //结束编辑,回收键盘
    [self.view endEditing:YES];
}

- (void)setupSubviews {
    
    [self.tableView registerClass:[AddContactCell class] forCellReuseIdentifier:[AddContactCell reuseIdentifier]];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}
#pragma mark - 取消和保存事件
//取消
- (void)cancel:(UIBarButtonItem *)sender{
    //关闭键盘
    [self.view endEditing:YES];
    //返回
    [self dismissViewControllerAnimated:YES completion:nil];
}
//保存
- (void)save:(UIBarButtonItem *)sender{
    [self.view endEditing:YES];
    //检查输入
    if ([self checkForSave]) {
        //创建model
        Person *per = [Person new];
        //model赋值
        [_dataList enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *value = obj[@"value"];
            if(idx == 0){
                per.name = value;
            }else if(idx == 1){
                per.account = value;
            }else if(idx == 2){
                per.comment = value;
            }
        }];
        per.image = @"logo_van_green";
        [_delegate sendPerson:per];
        //关闭键盘
        [self.view endEditing:YES];
        //返回上个界面
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)checkNextEnable {
    __block NSInteger enable = 0;
    [_dataList enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *value = obj[@"value"];
        value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (idx < 4 && value.length > 0) {
            enable |= (1 << idx);
        }
    }];
    if (enable == 3 || enable == 7) {
        if (!self.nextButton.userInteractionEnabled) {
            self.nextButton.userInteractionEnabled = YES;
            self.nextButton.backgroundColor = [UIColor colorWithRGBHex:0x08B2B8];
        }
    } else {
        if (self.nextButton.userInteractionEnabled) {
            self.nextButton.userInteractionEnabled = NO;
            self.nextButton.backgroundColor = [UIColor colorWithRGBHex:0xA3CFFF];
        }
    }
}

#pragma mark - 保存验证
- (BOOL)checkForSave{
    static NSString *name = nil;
    static NSString *account = nil;
    static NSString *comment = nil;
    //判断姓名和电话号码是否为空
    [_dataList enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *value = obj[@"value"];
        if(idx == 0){
            name = [[NSString alloc] initWithString:value];
        }else if(idx == 1){
            account = [[NSString alloc] initWithString:value];
        }else if(idx == 2){
            comment = [[NSString alloc] initWithString:value];
        }
    }];
    if ([name isEqualToString:@""] || name == nil || [account isEqualToString:@""] || account == nil) {
        _alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil) message:NSLocalizedString(@"姓名或区块链账号不能为空",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil, nil];
        [_alertView show];
        return NO;
    }
    if (![ RegularExpression validateVktAccountName:account]) {
        [TOASTVIEW showWithText:NSLocalizedString(@"账号名,5~12位字符,只能由小写a~z和1~5组成!", nil)];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self isViewLoaded] == YES && self.view.window == nil) {
        self.view = nil;
    }
}

#pragma mark - AddContactCellDelegate

- (void)addContactCell:(AddContactCell *)cell valueChange:(NSString *)value {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSMutableDictionary *data = _dataList[indexPath.row];
    data[@"value"] = value;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self checkNextEnable];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddContactCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddContactCell reuseIdentifier] forIndexPath:indexPath];
    NSDictionary *data = [self.dataList objectAtIndex:indexPath.row];
    [cell textFieldEnable:[data[@"textFieldEnable"] boolValue]];
    [cell updateWithTitle:data[@"title"] value:data[@"value"]];
    cell.delegate = self;
    if (indexPath.row == 2) {
        cell.inputTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    } else if (indexPath.row == 1) {
        cell.inputTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    } else {
        cell.inputTextField.keyboardType = UIKeyboardTypeDefault;
    }
    
    NSString *placeHolder = data[@"placeHolder"];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:placeHolder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithRGBHex:0xDDDDDD]}];
    cell.inputTextField.attributedPlaceholder = att;
    NSString *action = data[@"action"];
    cell.accessoryType = action.length > 0 ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self.dataList objectAtIndex:indexPath.row];
    NSString *action = data[@"action"];
    if (action.length > 0 && [self respondsToSelector:NSSelectorFromString(action)]) {
        [self performSelector:NSSelectorFromString(action)];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - get & set
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRGBHex:0xD3D3D3];//#A3CFFF 100% 0x2890FE
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 4;
        btn.userInteractionEnabled = NO;
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 47)];
        [footer addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(footer).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
        _nextButton = btn;
        _tableView.tableFooterView = footer;
        _tableView.separatorColor = [UIColor colorWithRGBHex:0xE8E8E8];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}


- (NSArray *)dataList {
    if (!_dataList) {
        NSMutableArray *dataList = [NSMutableArray arrayWithCapacity:3];
        [dataList addObject:@{@"title":NSLocalizedString(@"名称",nil),@"value":@"",@"action":@"",@"textFieldEnable":@YES,@"placeHolder":NSLocalizedString(@"请输入名称",nil)}.mutableCopy];
        [dataList addObject:@{@"title":NSLocalizedString(@"账号",nil),@"value":@"",@"action":@"",@"textFieldEnable":@YES,@"placeHolder":NSLocalizedString(@"请输入或者粘贴账号名称",nil)}.mutableCopy];
        [dataList addObject:@{@"title":NSLocalizedString(@"备注",nil),@"value":@"",@"action":@"",@"textFieldEnable":@YES,@"placeHolder":NSLocalizedString(@"请输入备注",nil)}.mutableCopy];
        _dataList = [dataList copy];
    }
    return _dataList;
}

@end
