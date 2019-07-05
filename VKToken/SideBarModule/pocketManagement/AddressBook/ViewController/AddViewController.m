//
//  AddViewController.m
//  AddressBook1.0
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AddViewController.h"


@interface AddViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (nonatomic,retain) UIButton *image;
@property (nonatomic,retain) UITextField *name;
@property (nonatomic,retain) UITextField *account;
@property (nonatomic,retain) UITextField *comment;
@property (nonatomic,retain) UIImagePickerController *pick;
@property (nonatomic,retain) UIAlertView *alertView;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //创建视图
    [self createView];
    //设置navigationBar
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //设置左右button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    //设置手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - 点击屏幕回收键盘
- (void)tapClick:(UITapGestureRecognizer *)sender{
    //结束编辑,回收键盘
    [self.view endEditing:YES];
}

//创建视图
- (void)createView{
    
    //姓名
    _name = [[UITextField alloc] initWithFrame:CGRectMake(80, 20, 200, 30)];
    _name.borderStyle = UITextBorderStyleRoundedRect;
    _name.placeholder = @"姓名";
    _name.returnKeyType = UIReturnKeyNext;
    _name.delegate = self;
    [self.view addSubview:_name];
    //账号
    _account = [[UITextField alloc] initWithFrame:CGRectMake(80, 60, 200, 30)];
    _account.borderStyle = UITextBorderStyleRoundedRect;
    _account.placeholder = @"账号";
    _account.returnKeyType = UIReturnKeyNext;
    _account.delegate = self;
    [self.view addSubview:_account];
    //备注
    _comment = [[UITextField alloc] initWithFrame:CGRectMake(80, 100, 200, 30)];
    _comment.borderStyle = UITextBorderStyleRoundedRect;
    _comment.placeholder = @"备注";
    _comment.returnKeyType = UIReturnKeyDone;
    _comment.delegate = self;
    [self.view addSubview:_comment];
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
    //检查输入
    if ([self checkForSave]) {
        //创建model
        Person *per = [Person new];
        //model赋值
        per.name = _name.text;
        per.image = @"logo_van_green";
        per.account = _account.text;
        per.comment = _comment.text;
        //代理传值
        [_delegate sendPerson:per];
        //关闭键盘
        [self.view endEditing:YES];
        //返回上个界面
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 添加头像事件
- (void)addPhoto:(UIButton *)sender{
    //UIImagePickerController
    _pick = [[UIImagePickerController alloc] init];
    //设置数据源
    _pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //设置是否可以编辑
    _pick.allowsEditing = YES;
    //设置代理
    _pick.delegate = self;
    //显示
    [self presentViewController:_pick animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //获取编辑后的图片
    UIImage* original = [info objectForKey:UIImagePickerControllerEditedImage];
    //button显示头像
    [_image setImage:original forState:UIControlStateNormal];
    //退出
    [_pick dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textField代理事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField isEqual:_name]) {
        [_account becomeFirstResponder];
        return YES;
    }else if ([textField isEqual:_account]){
        [_comment becomeFirstResponder];
        return YES;
    }
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 保存验证
- (BOOL)checkForSave{
    //判断姓名和电话号码是否为空
    if ([_name.text isEqualToString:@""] || _name.text == nil || [_account.text isEqualToString:@""] || _account.text == nil) {
        _alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"姓名或区块链账号不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [_alertView show];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
