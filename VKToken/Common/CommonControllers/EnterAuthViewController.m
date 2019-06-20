//
//  EnterAuthViewController.m
//  VKToken
//
//  Created by 李轶 on 2019/6/19.
//  Copyright © 2019 vankiachain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnterAuthViewController.h"
#import "AuthPasswordViewController.h"
#import "AuthID.h"
#import "Macro.h"

@import Toast;

@interface EnterAuthViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *authTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *authTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *passcodeButton;

@property (strong, nonatomic) NSString *authType;
@property (assign, nonatomic) BOOL firstLoad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@end

@implementation EnterAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstLoad = YES;
    [self settingBackgroundView];
    [self settingAuthTypeIcon];
    [self gotoAuth];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (IBAction)onPasswordButtonTapped:(id)sender {
    AuthPasswordViewController *vc = [[AuthPasswordViewController alloc] initWithNibName:@"AuthPasswordViewController" bundle:nil];
    vc.pwdType = kPasswordTypeEnter;
    vc.title = NSLocalizedString(@"auth_pwd",nil);
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onDeviceAuthButtonTapped:(id)sender {
    [self gotoAuth];
}

- (void)gotoAuth {
    if ([self.authType isEqualToString:kAuthTypePassword]) {
        if (self.firstLoad) {
            self.firstLoad = NO;
            return;
        }
        [self onPasswordButtonTapped:nil];
    } else {
        [self askDeviceBiometricAuth];
    }
}

- (void)askDeviceBiometricAuth {
    __weak typeof(self) weakSelf = self;
    [[AuthID sharedInstance] tb_showAuthIDWithDescribe:nil BlockState:^(AuthIDState state, NSError *error) {
        if (state == AuthIDStateNotSupport) { // 不支持TouchID/FaceID
        } else if(state == AuthIDStateFail) { // 验证失败
        } else if(state == AuthIDStateTouchIDLockout || state == AuthIDStateInputPassword || state == AuthIDStateSystemCancel || state == AuthIDStateUserCancel) {   // 多次错误，已被锁定
        } else if (state == AuthIDStateSuccess) { // TouchID/FaceID验证成功
            [weakSelf authSuccess];
        }
    }];
}

- (void)authSuccess {
    [[NSNotificationCenter defaultCenter] postNotificationName:kAuthEnterAppSuccessNotification
                                                        object:nil];
}

- (void)settingAuthTypeIcon {
    _authType = [[NSUserDefaults standardUserDefaults] objectForKey:kAuthTypeKey];
    if (_authType) {
        NSString *iconname = @"icon_auth_password";
        NSString *title = NSLocalizedString(@"touch_pwd", nil);
        if ([_authType isEqualToString:kAuthTypeTouchId]) {
            iconname = @"icon_touchid";
            title = NSLocalizedString(@"touch_touchId", nil);
        } else if ([_authType isEqualToString:kAuthTypeFaceId]) {
            iconname = @"icon_faceid";
            title = NSLocalizedString(@"touch_faceId", nil);
        } else {
            self.passcodeButton.hidden = YES;
        }
        self.authTypeImage.image = [UIImage imageNamed:iconname];
        self.authTypeLabel.text = title;
    }
}

- (void)settingBackgroundView {
    UIImage *backImage = nil;
    self.topConstraint.constant = 350;
    if (kIphoneX) {
        backImage = [UIImage imageNamed:@"bg_auth_812"];
    } else if (kScreenHeight == 736) {
        backImage = [UIImage imageNamed:@"bg_auth_736"];
    } else if (kScreenHeight == 667) {
        backImage = [UIImage imageNamed:@"bg_auth_667"];
    } else {
        backImage = [UIImage imageNamed:@"bg_auth_568"];
        self.topConstraint.constant = 280;
    }
    self.backgroundImageView.image = backImage;
}

@end
