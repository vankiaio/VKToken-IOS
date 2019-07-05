//
//  ContactTableViewController.h
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 从网络请求获取的Account数组, 还是从本地获取的Account数据
 */
typedef NS_ENUM(NSInteger, ChangeContactDataArrayType) {
    ChangeContactDataArrayTypeLocal = 0,
    ChangeContactDataArrayTypeNetworking ,
};


@protocol ChangeContactViewControllerDelegate<NSObject>
- (void)changeContactCellDidClick:(NSString *)name;
@end

@interface ContactTableViewController : UITableViewController

/**
 从网络请求获取的Account数组, 还是从本地获取的Account数据
 */
@property(nonatomic, assign) ChangeContactDataArrayType changeContactDataArrayType;

@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, weak) id<ChangeContactViewControllerDelegate> delegate;

@end
