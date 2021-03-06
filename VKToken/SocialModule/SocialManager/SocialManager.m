//
//  SocialManager.m
//  VKToken
//
//  Created by vankiachain on 2018/3/27.
//  Copyright © 2018年 vankiachain. All rights reserved.
//

#import "SocialManager.h"


#define WX_APP_ID @"wx54d2b8e4b2e42792"
#define WX_AppSecret @"3fccafd6d2a6002bb34c758b789ebfa6"
#define UNIVERSAL_LINK @"https://vktokendev.github.io/"

#define QQ_APP_ID @"1109933169"
#define QQ_KEY @"yVtwKwZXlZUsqML2"

@interface SocialManager()

@end


@implementation SocialManager

+ (SocialManager *)socialManager{
    static SocialManager *socialManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socialManager = [[self alloc] init];
    });
    return socialManager;
    
}

- (void)initWithSocialSDK:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册微信SDK
    BOOL result =  [WXApi registerApp:WX_APP_ID universalLink:UNIVERSAL_LINK ];
    if (result) {
        NSLog(@"WXApi registerApp status 1");
    }else{
        NSLog(@"WXApi registerApp status 0");
    }
    
}

- (BOOL)initWithSocialSDK:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)initWithSocialSDK:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)initWithSocialSDK:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler {
    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
}

- (BOOL) completion{
    return true;
}

#pragma mark qq
- (void)qqLoginRequest{
    self.socialType = kQQ;
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_APP_ID andDelegate:self];
    NSArray *permissions = @[kOPEN_PERMISSION_GET_SIMPLE_USER_INFO, kOPEN_PERMISSION_ADD_SHARE, kOPEN_PERMISSION_GET_INFO, kOPEN_PERMISSION_GET_USER_INFO];
    [self.tencentOAuth authorize:permissions];
}


- (void)qqShareToScene:(int)scene withShareModel:(ShareModel *)model{
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_APP_ID andDelegate:self];
     QQApiURLObject  *qqObject = [QQApiURLObject objectWithURL:[NSURL URLWithString:model.webPageUrl] title:model.title description:model.detailDescription previewImageData:UIImageJPEGRepresentation([UIImage imageNamed:model.imageName], 1) targetContentType:QQApiURLTargetTypeNews];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:qqObject];
    if (scene == 0) {// 好友
        [QQApiInterface sendReq:req];
    }else if(scene == 1){// 空间
        [QQApiInterface SendReqToQZone:req];
    }
}

- (void)qqShareToScene:(int)scene withShareImage:(UIImage *)image{
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_APP_ID andDelegate:self];
    QQApiImageObject *imgObj = [QQApiImageObject objectWithData:UIImagePNGRepresentation(image) previewImageData:UIImagePNGRepresentation(image) title:nil description:nil];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:imgObj];
    if (scene == 0) {// 好友
        [QQApiInterface sendReq:req];
    }else if(scene == 1){// 空间
        [QQApiInterface SendReqToQZone:req];
    }
    
}



-(void)tencentDidLogin{
    NSLog(@"%@", self.tencentOAuth.openId);
    [self.tencentOAuth getUserInfo];
}

-(void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled)
    {
        [TOASTVIEW showWithText:NSLocalizedString(@"用户取消登录", nil)];
    }
    else
    {
        [TOASTVIEW showWithText:NSLocalizedString(@"qq登录失败", nil)];
    }
}

-(void)getUserInfoResponse:(APIResponse *)response{
    NSLog(@"userInfo： response %@",response.jsonResponse);
    if(IsNilOrNull(self.onQQLoginSuccess)){
        return;
    }
    SocialModel *model = [[SocialModel alloc] init];
    model.name = VALIDATE_STRING(response.jsonResponse[@"nickname"]);
    model.avatar = VALIDATE_STRING(response.jsonResponse[@"figureurl_2"]);
    model.openid = VALIDATE_STRING(self.tencentOAuth.openId);
    self.onQQLoginSuccess(model);
}

-(void)tencentDidNotNetWork{
    [TOASTVIEW showWithText:NSLocalizedString(@"无网络连接，请设置网络", nil)];
}

-(void)addShareResponse:(APIResponse *)response{
    NSLog(@"%@",response);
}


#pragma mark wechat
- (void)wechatLoginRequest{
    self.socialType = kWechat;
    SendAuthReq *req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"1";
    [WXApi sendReq:req completion:NULL];
//   BOOL result =  [WXApi sendReq:req completion:NULL];
//    if (result) {
//        NSLog(@"WXApi sendReq status 1");
//    }else{
//        NSLog(@"WXApi sendReq status 0");
//    }
    
}

//WXApiDelegate
-(void)onReq:(BaseReq *)req{
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
    }
    else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
    }
    else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
    }
}

-(void)onResp:(BaseResp *)resp{
    
    [SVProgressHUD show];
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        [SVProgressHUD dismiss];
    }else if ([resp isKindOfClass:[SendAuthResp class]]){
        if (resp.errCode == 0) {
            // 用户同意
            NSString *authCode = [(SendAuthResp *)resp code];
            if (IsStrEmpty(authCode)) {
                [TOASTVIEW showWithText: NSLocalizedString(@"微信认证失败", nil)];
            }else{
                AFHTTPSessionManager *outerNetworkingManager = [[AFHTTPSessionManager alloc] init];
                [outerNetworkingManager.requestSerializer setValue: @"application/json" forHTTPHeaderField: @"Accept"];
                [outerNetworkingManager.requestSerializer setValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
                [outerNetworkingManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/plain",@"text/json", @"text/javascript", nil]];
                NSDictionary *params = @{@"appid": WX_APP_ID, @"secret":WX_AppSecret, @"code": authCode, @"grant_type": @"authorization_code"};
                WS(weakSelf);
                [outerNetworkingManager POST:@"https://api.weixin.qq.com/sns/oauth2/access_token" parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"%@" ,responseObject);
                    [weakSelf getWeChatUserInfo: responseObject];
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"%@", error);
                    [SVProgressHUD dismiss];
                }];
            }
            
        }else if (resp.errCode == -4){
            // 用户拒绝授权
            [SVProgressHUD dismiss];
            self.onWechatLoginFailed(resp);
        }else if (resp.errCode == -2){
            // 用户取消
            [SVProgressHUD dismiss];
            self.onWechatLoginFailed(resp);
        }else{
            [SVProgressHUD dismiss];
            self.onWechatLoginFailed(resp);
        }
    }else if ([resp isKindOfClass:[AddCardToWXCardPackageResp class]]) {
        [SVProgressHUD dismiss];
    }
    
}

//获取微信用户信息
- (void)getWeChatUserInfo:(NSDictionary *) tokenDictionary{
    AFHTTPSessionManager *outerNetworkingManager = [[AFHTTPSessionManager alloc] init];
    [outerNetworkingManager.requestSerializer setValue: @"application/json" forHTTPHeaderField: @"Accept"];
    [outerNetworkingManager.requestSerializer setValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
    [outerNetworkingManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/plain",@"text/json", @"text/javascript", nil]];
    
    NSDictionary *dictionary = @{@"access_token": VALIDATE_STRING([tokenDictionary objectForKey: @"access_token"]),
                                 @"openid": VALIDATE_STRING([tokenDictionary objectForKey: @"openid"])};
    
    WS(weakSelf);
    [outerNetworkingManager POST: @"https://api.weixin.qq.com/sns/userinfo" parameters: dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
        [SVProgressHUD dismiss];
        if(IsNilOrNull(weakSelf.onWechatLoginSuccess)){
            return;
        }
        NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary: responseObject];
        [resultDic setObject: VALIDATE_STRING([tokenDictionary objectForKey: @"access_token"]) forKey: @"access_token"];
        SocialModel *model = [[SocialModel alloc] init];
        model.name = VALIDATE_STRING(responseObject[@"nickname"]);
        model.avatar = VALIDATE_STRING(responseObject[@"headimgurl"]);
        model.openid = VALIDATE_STRING(responseObject[@"openid"]);
        model.unionid = VALIDATE_STRING(responseObject[@"unionid"]);
        weakSelf.onWechatLoginSuccess(model);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
        [SVProgressHUD dismiss];
    }];
  
}

/**WXWebpageObject
 scene:: WXScene {
 WXSceneSession  = 0,  聊天界面
 WXSceneTimeline = 1,   朋友圈
 WXSceneFavorite = 2,    收藏
 */
- (void)wechatShareToScene:(int)scene withShareModel:(ShareModel *)model{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = model.title;
    message.description = model.detailDescription;
    [message setThumbImage:[UIImage imageNamed: model.imageName]];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = model.webPageUrl;
    message.mediaObject = webpageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req completion:NULL];
}

/**WXImageObject
 scene:: WXScene {
 WXSceneSession  = 0,  聊天界面
 WXSceneTimeline = 1,   朋友圈
 WXSceneFavorite = 2,    收藏
 */
- (void)wechatShareImageToScene:(int)scene withImage:(UIImage *)image{
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData =UIImagePNGRepresentation(image);
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.mediaObject = imageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    [WXApi sendReq:req completion:NULL];
}






@end
