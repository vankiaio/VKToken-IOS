//
//  SearchResultController.h
//  AddressBook1.0
//
//  Created by 王林 on 15/10/8.
//  Copyright © 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactTableViewController.h"
@interface SearchResultController : UITableViewController<UISearchControllerDelegate,UISearchResultsUpdating>
/**
 从网络请求获取的Account数组, 还是从本地获取的Account数据
 */
@property (nonatomic, strong) NSMutableDictionary *datas;
@property(nonatomic, weak) id<ChangeContactViewControllerDelegate> delegate;
@property(nonatomic, weak) ContactTableViewController *parent;
@end
