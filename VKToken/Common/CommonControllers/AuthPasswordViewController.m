//
//  AuthPasswordViewController.m
//  TokenBank
//
//  Created by MarcusWoo on 13/02/2018.
//  Copyright © 2018 MarcusWoo. All rights reserved.
//

#import "AuthPasswordViewController.h"
//#import "UIColor+Hex.h"
#import "NSString+.h"
#import "Macro.h"
#import "AuthID.h"
#import "UIImage+.h"
#import "ToastView.h"

@import LocalAuthentication;
//@import IQKeyboardManager;
@import Toast;

@interface AuthPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *pwd1;
@property (weak, nonatomic) IBOutlet UITextField *pwd2;
@property (weak, nonatomic) IBOutlet UITextField *pwd3;
@property (weak, nonatomic) IBOutlet UITextField *pwd4;
@property (weak, nonatomic) IBOutlet UITextField *pwd5;
@property (weak, nonatomic) IBOutlet UITextField *pwd6;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIView *passcodeBg;

@property (weak, nonatomic) IBOutlet UIView *reAuthBg;
@property (weak, nonatomic) IBOutlet UIImageView *reAuthImageView;

@property (nonatomic, assign) AuthSupportType authType;
@property (nonatomic, strong) NSArray *pwds;
@property (nonatomic, strong) NSMutableString *pwdString;
@property (nonatomic, assign) BOOL wasKeyboardManagerEnabled;
@property (nonatomic, strong) NSString *tipString;
//localized
@property (weak, nonatomic) IBOutlet UILabel *tapToReAuthLabel;

@end

@implementation AuthPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.passcodeBg.layer.borderWidth = 1;
    self.passcodeBg.layer.cornerRadius = 3;
    self.passcodeBg.layer.borderColor = [UIColor colorWithRGBHex:0xaaaaaa].CGColor;
    self.passcodeBg.layer.masksToBounds = YES;
    
    [self.nextButton setBackgroundImage:[UIImage tb_imageWithColor:[UIColor colorWithRGBHex:0x2890FE] andSize:CGSizeMake(150, 45)] forState:UIControlStateNormal];
    [self.nextButton setBackgroundImage:[UIImage tb_imageWithColor:[UIColor colorWithRGBHex:0x2890FE alpha:0.4] andSize:CGSizeMake(150, 45)] forState:UIControlStateDisabled];
    self.nextButton.layer.cornerRadius = 3;
    self.nextButton.layer.masksToBounds = YES;
    self.nextButton.enabled = NO;
    self.nextButton.hidden = self.pwdType != kPasswordTypeSet;
    
    self.reAuthBg.hidden = YES;
    
    // Do any additional setup after loading the view from its nib.
    [self.pwd1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd3 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd4 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd5 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd6 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.pwd1 becomeFirstResponder];
    
    self.pwds = @[self.pwd1,self.pwd2,self.pwd3,self.pwd4,self.pwd5,self.pwd6];
    
    if (self.pwdType == kPasswordTypeSet) {
        _tipString = NSLocalizedString(@"set_pwd",nil);
    } else if (self.pwdType == kPasswordTypeReconfirm) {
        _tipString = NSLocalizedString(@"repeat_pwd",nil);
    } else if (self.pwdType == kPasswordTypeEnter) {
        _tipString = NSLocalizedString(@"input_pwd_auth",nil);
    } else if (self.pwdType == kPasswordTypeCancel) {
        _tipString = NSLocalizedString(@"input_pwd_auth",nil);
    }
    self.tipLabel.text = _tipString;
    
    _authType = [[AuthID sharedInstance] supportBiometricType];
    if (_authType != AuthSupportTypeNone) {
        BOOL isTouchID = _authType==AuthSupportTypeTouchID;
        self.reAuthImageView.image = [UIImage imageNamed:isTouchID?@"icon_touchid":@"icon_faceid"];
    }
}

- (void)changeLanguage {
    self.tapToReAuthLabel.text = NSLocalizedString(@"tap_reauth",nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)checkButtonsStatus {
    BOOL enable = YES;
    if (self.pwd1.text.length != 1) {   enable = NO;    }
    if (self.pwd2.text.length != 1) {   enable = NO;    }
    if (self.pwd3.text.length != 1) {   enable = NO;    }
    if (self.pwd4.text.length != 1) {   enable = NO;    }
    if (self.pwd5.text.length != 1) {   enable = NO;    }
    if (self.pwd6.text.length != 1) {   enable = NO;    }
    self.nextButton.enabled = enable;
    
    self.reAuthBg.userInteractionEnabled = enable;
    self.reAuthImageView.alpha = enable?1.0:0.5;
}

- (void)textFieldDidChange:(UITextField *)textfield {
    
    if (![self.tipLabel.text isEqualToString:self.tipString]) {
        self.tipLabel.text = self.tipString;
        self.tipLabel.textColor = [UIColor colorWithRGBHex:0x333333];
    }
    
    if (textfield.text.length >= 1) {
        if (textfield.text.length == 2) {
            textfield.text = [textfield.text substringWithRange:NSMakeRange(1, 1)];
        } else {
            textfield.text = [textfield.text substringToIndex:1];
        }
    }
    
    [self checkButtonsStatus];
    
    NSInteger index = [self.pwds indexOfObject:textfield];
    switch (index) {
        case 0:
            [self.pwd2 becomeFirstResponder];
            break;
        case 1:
            [self.pwd3 becomeFirstResponder];
            break;
        case 2:
            [self.pwd4 becomeFirstResponder];
            break;
        case 3:
            [self.pwd5 becomeFirstResponder];
            break;
        case 4:
            [self.pwd6 becomeFirstResponder];
            break;
        case 5: {
            if (self.pwd1.text.length == 0) {
                [self.pwd1 becomeFirstResponder];
                break;
            }
            if (self.pwd2.text.length == 0) {
                [self.pwd2 becomeFirstResponder];
                break;
            }
            if (self.pwd3.text.length == 0) {
                [self.pwd3 becomeFirstResponder];
                break;
            }
            if (self.pwd4.text.length == 0) {
                [self.pwd4 becomeFirstResponder];
                break;
            }
            if (self.pwd5.text.length == 0) {
                [self.pwd5 becomeFirstResponder];
                break;
            }
            self.pwdString = @"".mutableCopy;
            for (UITextField *tf in self.pwds) {
                [self.pwdString appendString:tf.text];
            }
            
            [self.pwd6 resignFirstResponder];
            [self passwordFilledAction];
        }
            break;
            
        default:
            break;
    }
}

- (void)passwordFilledAction {
    switch (self.pwdType) {
        case kPasswordTypeSet: {
            AuthPasswordViewController *vc = [[AuthPasswordViewController alloc] initWithNibName:@"AuthPasswordViewController" bundle:nil];
            vc.prePassword = self.pwdString;
            vc.pwdType = kPasswordTypeReconfirm;
            vc.title = self.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case kPasswordTypeReconfirm:
            if ([self.prePassword isEqualToString:self.pwdString]) {
                NSString *encodedPwd = [self.pwdString tb_md5];
                if (encodedPwd) {
                    if (self.authType != AuthSupportTypeNone) {
                        [self deviceConfirmAction];
                    } else {
                        [self authSuccess];
                    }
                } else {
                    [self.view makeToast:NSLocalizedString(@"contact_us",nil) duration:1.0 position:CSToastPositionCenter];
                }
            } else {
                self.tipLabel.text = NSLocalizedString(@"wrong_pwd",nil);
                self.tipLabel.textColor = [UIColor redColor];
                for (UITextField *tf in self.pwds) {
                    tf.text = @"";
                }
                [self.pwd1 becomeFirstResponder];
            }
            break;
        case kPasswordTypeEnter: {
            NSString *encodedPwd = [self.pwdString tb_md5];
            NSString *md5Pwd = [[NSUserDefaults standardUserDefaults] objectForKey:kAuthPasswordKey];
            if (![encodedPwd isEqualToString:md5Pwd]) {
                self.tipLabel.text = NSLocalizedString(@"wrong_pwd",nil);
                self.tipLabel.textColor = [UIColor redColor];
                for (UITextField *tf in self.pwds) {
                    tf.text = @"";
                }
                [self.pwd1 becomeFirstResponder];
            } else {
                [self notiToMain];
            }
        }
            break;
        case kPasswordTypeCancel: {
            NSString *encodedPwd = [self.pwdString tb_md5];
            NSString *md5Pwd = [[NSUserDefaults standardUserDefaults] objectForKey:kAuthPasswordKey];
            if (![encodedPwd isEqualToString:md5Pwd]) {
                self.tipLabel.text = NSLocalizedString(@"wrong_pwd",nil);
                self.tipLabel.textColor = [UIColor redColor];
                for (UITextField *tf in self.pwds) {
                    tf.text = @"";
                }
                [self.pwd1 becomeFirstResponder];
            } else {
                [self cancelPassword];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
            break;
        default:
            break;
    }
}

- (void)notiToMain {
    [[NSNotificationCenter defaultCenter] postNotificationName:kAuthEnterAppSuccessNotification object:nil];
}

//使用设备验证（Touch ID, Face ID）
- (void)deviceConfirmAction {
    __weak typeof(self) weakSelf = self;
    [[AuthID sharedInstance] tb_showAuthIDWithDescribe:nil BlockState:^(AuthIDState state, NSError *error) {
        if (state == AuthIDStateNotSupport) { // 不支持TouchID/FaceID
//            Log([[LocalizedHelper standardHelper] stringWithKey:@""]@"对不起，当前设备不支持指纹/面部ID");
        } else if(state == AuthIDStateFail) { // 验证失败
//            Log([[LocalizedHelper standardHelper] stringWithKey:@""]@"指纹/面部ID不正确，验证失败");
            [weakSelf.view makeToast:NSLocalizedString(@"auth_failed",nil) duration:0.8 position:CSToastPositionBottom];
        } else if(state == AuthIDStateTouchIDLockout || state == AuthIDStateInputPassword || state == AuthIDStateSystemCancel || state == AuthIDStateUserCancel) {   // 多次错误，已被锁定
//            Log([[LocalizedHelper standardHelper] stringWithKey:@""]@"多次错误，指纹/面部ID已被锁定，请到手机解锁界面输入密码");
            if (weakSelf.pwdType == kPasswordTypeReconfirm) {
                weakSelf.reAuthBg.hidden = NO;
                [weakSelf checkButtonsStatus];
            }
        } else if (state == AuthIDStateSuccess) { // TouchID/FaceID验证成功
            [weakSelf authSuccess];
        }
    }];
}

- (void)authSuccess {
    
    NSString *encodedPwd = [self.pwdString tb_md5];
    if (encodedPwd) {
        [[NSUserDefaults standardUserDefaults] setObject:encodedPwd forKey:kAuthPasswordKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    __weak typeof(self) weakSelf = self;
    [self.view makeToast:NSLocalizedString(@"setting_succ",nil) duration:0.2
                position:CSToastPositionCenter title:nil
                   image:nil
                   style:[[CSToastStyle alloc] initWithDefaultStyle] completion:^(BOOL didTap) {
                       if (weakSelf.authType != AuthSupportTypeNone) {
                           if (kIphoneX) {
                               [[NSUserDefaults standardUserDefaults] setObject:kAuthTypeFaceId forKey:kAuthTypeKey];
                           } else {
                               [[NSUserDefaults standardUserDefaults] setObject:kAuthTypeTouchId forKey:kAuthTypeKey];
                           }
                       } else {
                           [[NSUserDefaults standardUserDefaults] setObject:kAuthTypePassword forKey:kAuthTypeKey];
                       }
                       
                       [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:kAuthSwithOnStatusKey];
                       [[NSUserDefaults standardUserDefaults] synchronize];
                       
                       if (weakSelf.navigationController.viewControllers.count > 1) {
                           UIViewController *destVC = [weakSelf.navigationController.viewControllers objectAtIndex:1];
                           [weakSelf.navigationController popToViewController:destVC animated:YES];
                       }
                   }];
}

- (void)cancelPassword {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAuthSwithOnStatusKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAuthPasswordKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAuthTypeKey];
}

- (IBAction)onNextButtonTapped:(id)sender {
    self.pwdString = @"".mutableCopy;
    for (UITextField *tf in self.pwds) {
        [self.pwdString appendString:tf.text];
    }
    
    [self.pwds makeObjectsPerformSelector:@selector(resignFirstResponder)];
    [self passwordFilledAction];
}

- (IBAction)onReauthButtonTapped:(id)sender {
    [self deviceConfirmAction];
}


@end
