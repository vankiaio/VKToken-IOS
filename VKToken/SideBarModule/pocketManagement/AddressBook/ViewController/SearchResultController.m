//
//  SearchResultController.m
//  AddressBook1.0
//
//  Created by 王林 on 15/10/8.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import "SearchResultController.h"
#import "ContactCell.h"
#import "Person.h"

@import Masonry;
@import Toast;

@interface SearchResultController ()
@property (nonatomic, strong) NSMutableDictionary *results;
@property (nonatomic,retain) NSMutableArray *array;
@end

@implementation SearchResultController

//设置重用标志
static NSString *identifier = @"resultCell";

- (NSMutableDictionary *)results {
    if (_results == nil) {
        _results = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    return _results;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //注册cell
    [self.tableView registerClass:[ContactCell class] forCellReuseIdentifier:identifier];
    self.tableView.frame =self.view.bounds;
    _array = [[NSMutableArray alloc] initWithCapacity:0];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#pragma mark - 计算文本高度
//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //获取每个分组
    NSArray *arr = _results[_array[section]];
    return arr.count;
}

#pragma mark - tableview点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取点击的人
    NSArray *arr = self.results[_array[indexPath.section]];
    NSDictionary *dic = arr[indexPath.row];
    Person *per = [Person new];
    //赋值
    [per setValuesForKeysWithDictionary:dic];
//    [self.navigationController pushViewController:details animated:YES];
    

    if (self.delegate && [self.delegate respondsToSelector:@selector(changeContactCellDidClick:)]) {
        [self.delegate changeContactCellDidClick:per.account];
        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.parent.navigationController popViewControllerAnimated:NO];
        [self.parent dismissViewControllerAnimated:NO completion:nil];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    // Configure the cell...
    //获取
    Person *per = [Person new];
    NSArray *arr =  _results[_array[indexPath.section]];
    [per setValuesForKeysWithDictionary:arr[indexPath.row]];
    //设置
    cell.per = per;
    
    return cell;
}

#pragma mark - UISearchResultsUpdating代理事件
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //实现搜索功能
    NSString *inputStr = searchController.searchBar.text ;
    if (self.results.count > 0) {
        [self.results removeAllObjects];
        [self.array removeAllObjects];
    }
    for (NSString *section in self.datas) {
        for(NSArray *per in self.datas[section]){
            NSString *name = [per valueForKey:@"name"] ;
            NSString *account = [per valueForKey:@"account"] ;
            if ([name.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound ||
                [account.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {

                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[per valueForKey:@"name"],@"name",[per valueForKey:@"account"],@"account",[per valueForKey:@"image"],@"image",[per valueForKey:@"comment"],@"comment", nil];
                //获取联系人姓名首字母,并转化为大写
                NSString *key = [[[per valueForKey:@"name"] substringToIndex:1] capitalizedString];
                //判断分组是否存在
                NSMutableArray *arr = self.results[key];
                if (arr == nil) {
                    //如果分组不存在
                    arr = [NSMutableArray arrayWithObject:dic];
                    //添加分组
                    [self.results setObject:arr forKey:key];
                    //UI操作
                    //添加索引
                    [_array addObject:key];
                    [_array sortUsingSelector:@selector(compare:)];
                }else{
                    //如果存在,直接添加到末尾
                    [arr addObject:dic];
                }
            }
        }
    }
    
//    //获取分组名
//    _array = [NSMutableArray arrayWithArray:[_results allKeys]];
    //分组名排序
    [_array sortUsingSelector:@selector(compare:)];
    
    [self.tableView reloadData];
}

#pragma mark - UISearchControllerDelegate代理事件
- (void)willPresentSearchController:(UISearchController *)searchController{
    //设置取消按钮
    [searchController.searchBar setShowsCancelButton:YES animated:YES];
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
