//
//  AuthID.m
//  TokenBank
//
//  Created by MarcusWoo on 13/02/2018.
//  Copyright © 2018 MarcusWoo. All rights reserved.
//

#import "AuthID.h"
#import <UIKit/UIKit.h>
#import "Macro.h"
//#import "LocalizedHelper.h"

@implementation AuthID

+ (instancetype)sharedInstance {
    static AuthID *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AuthID alloc] init];
    });
    return instance;
}

- (AuthSupportType)supportBiometricType {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        if (kIphoneX) {
            return AuthSupportTypeFaceID;
        } else {
            return AuthSupportTypeTouchID;
        }
    } else {
        return AuthSupportTypeNone;
    }
}

- (void)tb_showAuthIDWithDescribe:(NSString *)desc BlockState:(StateBlock)block{
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            Log(@"系统版本不支持TouchID/FaceID (必须高于iOS 8.0才能使用)");
            block(AuthIDStateVersionNotSupport,nil);
        });
        
        return;
    }
    
    LAContext *context = [[LAContext alloc] init];
    
    // 验证失败提示信息，为 @"" 则不提示
    context.localizedFallbackTitle = NSLocalizedString(@"input_pwd", nil);
    
    NSError *error = nil;
    
    // LAPolicyDeviceOwnerAuthenticationWithBiometrics: 用TouchID/FaceID验证
    // LAPolicyDeviceOwnerAuthentication: 用TouchID/FaceID或密码验证, 默认是错误两次或锁定后, 弹出输入密码界面（本案例使用）
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:desc == nil ? NSLocalizedString(@"auth_with_touchId", nil) : desc reply:^(BOOL success, NSError * _Nullable error) {
            
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    Log(@"TouchID/FaceID 验证成功");
                    block(AuthIDStateSuccess,error);
                });
            }else if(error){
                
                if (@available(iOS 11.0, *)) {
                    switch (error.code) {
                        case LAErrorAuthenticationFailed:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID/FaceID 验证失败");
                                block(AuthIDStateFail,error);
                            });
                            break;
                        }
                        case LAErrorUserCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID/FaceID 被用户手动取消");
                                block(AuthIDStateUserCancel,error);
                            });
                        }
                            break;
                        case LAErrorUserFallback:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"用户不使用TouchID/FaceID,选择手动输入密码");
                                block(AuthIDStateInputPassword,error);
                            });
                        }
                            break;
                        case LAErrorSystemCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID/FaceID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                                block(AuthIDStateSystemCancel,error);
                            });
                        }
                            break;
                        case LAErrorPasscodeNotSet:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID/FaceID 无法启动,因为用户没有设置密码");
                                block(AuthIDStatePasswordNotSet,error);
                            });
                        }
                            break;
                            //case LAErrorTouchIDNotEnrolled:{
                        case LAErrorBiometryNotEnrolled:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID/FaceID 无法启动,因为用户没有设置TouchID");
                                block(AuthIDStateTouchIDNotSet,error);
                            });
                        }
                            break;
                            //case LAErrorTouchIDNotAvailable:{
                        case LAErrorBiometryNotAvailable:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID 无效");
                                block(AuthIDStateTouchIDNotAvailable,error);
                            });
                        }
                            break;
                            //case LAErrorTouchIDLockout:{
                        case LAErrorBiometryLockout:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID 被锁定(连续多次验证TouchID/FaceID失败,系统需要用户手动输入密码)");
                                block(AuthIDStateTouchIDLockout,error);
                            });
                        }
                            break;
                        case LAErrorAppCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                                block(AuthIDStateAppCancel,error);
                            });
                        }
                            break;
                        case LAErrorInvalidContext:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                                block(AuthIDStateInvalidContext,error);
                            });
                        }
                            break;
                        default:
                            break;
                    }
                } else {
                    // iOS 11.0以下的版本只有 TouchID 验证
                    switch (error.code) {
                        case LAErrorAuthenticationFailed:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID 验证失败");
                                block(AuthIDStateFail,error);
                            });
                            break;
                        }
                        case LAErrorUserCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID 被用户手动取消");
                                block(AuthIDStateUserCancel,error);
                            });
                        }
                            break;
                        case LAErrorUserFallback:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"用户不使用TouchID,选择手动输入密码");
                                block(AuthIDStateInputPassword,error);
                            });
                        }
                            break;
                        case LAErrorSystemCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID 被系统取消 (如遇到来电,锁屏,按了Home键等)");
                                block(AuthIDStateSystemCancel,error);
                            });
                        }
                            break;
                        case LAErrorPasscodeNotSet:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID 无法启动,因为用户没有设置密码");
                                block(AuthIDStatePasswordNotSet,error);
                            });
                        }
                            break;
                        case LAErrorTouchIDNotEnrolled:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID 无法启动,因为用户没有设置TouchID");
                                block(AuthIDStateTouchIDNotSet,error);
                            });
                        }
                            break;
                            //case :{
                        case LAErrorTouchIDNotAvailable:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID 无效");
                                block(AuthIDStateTouchIDNotAvailable,error);
                            });
                        }
                            break;
                        case LAErrorTouchIDLockout:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"TouchID 被锁定(连续多次验证TouchID失败,系统需要用户手动输入密码)");
                                block(AuthIDStateTouchIDLockout,error);
                            });
                        }
                            break;
                        case LAErrorAppCancel:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"当前软件被挂起并取消了授权 (如App进入了后台等)");
                                block(AuthIDStateAppCancel,error);
                            });
                        }
                            break;
                        case LAErrorInvalidContext:{
                            dispatch_async(dispatch_get_main_queue(), ^{
                                Log(@"当前软件被挂起并取消了授权 (LAContext对象无效)");
                                block(AuthIDStateInvalidContext,error);
                            });
                        }
                            break;
                        default:
                            break;
                    }
                }
                
            }
        }];
        
    }else{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            Log(@"当前设备不支持TouchID/FaceID");
            block(AuthIDStateNotSupport,error);
        });
        
    }
}

@end
