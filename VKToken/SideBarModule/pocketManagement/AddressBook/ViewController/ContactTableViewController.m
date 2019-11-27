//
//  ContactTableViewController.m
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ContactTableViewController.h"
#import "Person.h"
#import "AddViewController.h"
#import "ContactCell.h"
#import "SearchResultController.h"
@import Masonry;
@import Toast;

@interface ContactTableViewController ()<UITableViewDelegate,AddNewPerson>

@property (nonatomic,retain) NSMutableDictionary *dictionary;
@property (nonatomic,retain) NSMutableArray *array;
@property (nonatomic,retain) UISearchController *searchController;
@property (nonatomic,retain) NSString *addressPath;
@property (nonatomic , strong) UIBarButtonItem *backItem;
@property (nonatomic , strong) UIView *topView ;
@end

@implementation ContactTableViewController

//设置重用标志
static NSString *identifier = @"myCellReuse";


//数据处理
- (instancetype)initWithStyle:(UITableViewStyle)style{
    if (self = [super initWithStyle:style]) {
        //获取文件路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        _addressPath = [documentsDirectory stringByAppendingPathComponent:@"AddressBook.plist"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath: _addressPath])
        {
            _addressPath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat: @"AddressBook.plist"] ];
        }

        //获取文件内容(字典)
        _dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:_addressPath];
        if(!_dictionary){
            // If the file doesn’t exist, create an empty dictionary
            _dictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
        }
        //获取分组名
        _array = [NSMutableArray arrayWithArray:[_dictionary allKeys]];
        //分组名排序
        [_array sortUsingSelector:@selector(compare:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置navigationBar的颜色和标题
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:17.0f]}];
    self.navigationItem.title = NSLocalizedString(@"VKT账号本", nil);
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    //注册cell
    [self.tableView registerClass:[ContactCell class] forCellReuseIdentifier:identifier];
    //添加返回按钮
    self.navigationItem.leftBarButtonItems =@[self.backItem];
    [self.navigationItem.leftBarButtonItem.customView.widthAnchor constraintEqualToConstant:30].active = YES;
    [self.navigationItem.leftBarButtonItem.customView.heightAnchor constraintEqualToConstant:30].active = YES;
    //添加添加联系人按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewContact:)];
    //设置搜索控制器
    SearchResultController *searchresult = [[SearchResultController alloc] init];
    searchresult.datas = _dictionary;
    searchresult.delegate = self.delegate;
    searchresult.parent = self;
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchresult];
    // 设置结果更新代理
    self.searchController.searchResultsUpdater = searchresult;
    self.searchController.delegate = searchresult;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    [self.searchController.searchBar sizeToFit];
    
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.definesPresentationContext = NO;//不设置会导致一些位置错乱，无动画等问题
    
#warning searchBar上面的背景跟tableview不一样,怎么去掉

    self.topView = [UIView new];
    [self.topView addSubview:self.searchController.searchBar];
    [self.tableView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(-50);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.tableView.frame.size.width, 50));
    }];
    // 将topView移到最顶层，防止被其他view挡住
    [self.tableView bringSubviewToFront:self.topView];
    // 设置tableView的向下偏移50
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = self.tableView.contentOffset.y;
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        // 此处有加上navigationBar的高度
        make.top.mas_equalTo(offset - 5);
    }];
    [self.tableView layoutIfNeeded];
    // 将topView移到最顶层，防止被其他view挡住
    [self.tableView bringSubviewToFront:self.topView];
}

-(UIBarButtonItem *)backItem{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.lee_theme.LeeAddButtonImage(SOCIAL_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal).LeeAddButtonImage(BLACKBOX_MODE, [UIImage imageNamed:@"icon_back"], UIControlStateNormal);
        btn.lee_theme
        .LeeAddButtonTitleColor(SOCIAL_MODE, HEXCOLOR(0x000000), UIControlStateNormal)
        .LeeAddButtonTitleColor(BLACKBOX_MODE, HEXCOLOR(0xFFFFFF), UIControlStateNormal);
        [btn setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeNative) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        //左对齐
        //让返回按钮内容继续向左边偏移15，如果不设置的话，就会发现返回按钮离屏幕的左边的距离有点儿大，不美观
        btn.frame = CGRectMake(-40, -40, 50, 40);
        _backItem.customView = btn;
    }
    return _backItem;
}

- (void)closeNative {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 添加功能
//添加新联系人
- (void)addNewContact:(UIBarButtonItem *)sender{
    //创建视图
    AddViewController *add = [[AddViewController alloc] init];
    //设置代理
    add.delegate = self;
    //设置导航控制器
    UINavigationController *addNav = [[UINavigationController alloc] initWithRootViewController:add];
    //模态视图
    [self.navigationController presentViewController:addNav animated:YES completion:nil];
}

#pragma mark - Table view data source
//返回分组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return _array.count;
}
//返回分组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //获取每个分组
    NSArray *arr = _dictionary[_array[section]];
    return arr.count;
}
//设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    //获取
    Person *per = [Person new];
    NSArray *arr =  _dictionary[_array[indexPath.section]];
    [per setValuesForKeysWithDictionary:arr[indexPath.row]];
    //设置
    cell.per = per;
    
    return cell;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//设置快速索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _array;
}
//设置分组名
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _array[section];
}

#pragma mark - tableview点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取点击的人
    NSArray *arr = _dictionary[_array[indexPath.section]];
    NSDictionary *dic = arr[indexPath.row];
    Person *per = [Person new];
    //赋值
    [per setValuesForKeysWithDictionary:dic];
//    [self.navigationController pushViewController:details animated:YES];
    

    if (self.delegate && [self.delegate respondsToSelector:@selector(changeContactCellDidClick:)]) {
        [self.delegate changeContactCellDidClick:per.account];
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

#pragma mark - tableview编辑事件
//1.设置tableview可编辑
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    //父类发送消息
    [super setEditing:editing animated:animated];
    //tableview设置状态
    [self.tableView setEditing:editing animated:animated];
    //title状态
    self.editButtonItem.title = editing ? @"完成" : @"编辑";
}

//2.指定那些行可以被编辑(默认所有行都可以被编辑)
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//3.设置编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//4.完成编辑
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Delete the row from the data source
    //处理数据
    //获取分组
    NSString *key = _array[indexPath.section];
    NSMutableArray *arr = _dictionary[key];
    //判断分组人数
    if (arr.count == 1) {
        //删除整个分组
        //从dictionary中删除分组
        [_dictionary removeObjectForKey:key];
        //删除快速索引
        [_array removeObjectAtIndex:indexPath.section];
        //UI上处理
        //获取删除的分组
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
        //移除
        [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    }else{
        //删除联系人
        //从arr中移除联系人
        [arr removeObjectAtIndex:indexPath.row];
        //操作UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    [_dictionary writeToFile:_addressPath atomically:YES];
    
}

#pragma mark - tableview移动操作

//2.设置可以移动的行
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

//3.移动完成
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    //获取分组
    NSMutableArray *arr = _dictionary[_array[fromIndexPath.section]];
    //获取删除的联系人
    NSDictionary *dic = arr[fromIndexPath.row];
    //从原位置删除数据
    [arr removeObjectAtIndex:fromIndexPath.row];
    //插入到目标位置
    [arr insertObject:dic atIndex:toIndexPath.row];
    
}


//检测跨行移动
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath{
    //判断是否在同一个分组
    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
        
        return proposedDestinationIndexPath;
    }
    //不再在同一个分区,返回源路径
    return sourceIndexPath;
}


#pragma mark - tableview添加完成
- (void)sendPerson:(Person *)per{
    //数据处理
    //per信息转换为字典
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:per.name,@"name",per.account,@"account",per.image,@"image",per.comment,@"comment", nil];
    //获取联系人姓名首字母,并转化为大写
    NSString *key = [[per.name substringToIndex:1] capitalizedString];
    //判断分组是否存在
    NSMutableArray *arr = _dictionary[key];
    if (arr == nil) {
        //如果分组不存在
        arr = [NSMutableArray arrayWithObject:dic];
        //添加分组
        [_dictionary setObject:arr forKey:key];
        //UI操作
        //添加索引
        [_array addObject:key];
        [_array sortUsingSelector:@selector(compare:)];
    }else{
        //如果存在,直接添加到末尾
        [arr addObject:dic];
    }
    
    //保存数据
    if (![_dictionary writeToFile:_addressPath atomically:YES]) {
        // 0k, let's try to create a text file
        NSLog(@"Contact writing error!");
    }
    
    //重新加载数据
    [self.tableView reloadData];
    
}

//获取某个元素在数组中的下标
- (NSUInteger)getObjectIndexFromArray:(NSArray *)array andObject:(NSObject *)object{
    //循环
    for (int i = 0; i < array.count; i++) {
        //判断
        if ([object isEqual:array[i]]) {
            return i;
        }
    }
    
    return -1;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
