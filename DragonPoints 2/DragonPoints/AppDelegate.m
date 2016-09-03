//
//  AppDelegate.m
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "AppDelegate.h"
#import <AlipaySDK/AlipaySDK.h>
#define NAVI_TEST_BUNDLE_ID @"DragonPoints.DragonPoints"  //bundle ID
#define NAVI_TEST_APP_KEY   @"RIWfGsC0rou4wSX1qww65fuqKX85BdKo"  //APP KEY
static Reachability *reachability = nil;

static inline Reachability *defaultReachability()
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      reachability = [Reachability reachabilityForInternetConnection];
                  });
    return reachability;
}

@interface AppDelegate ()
{
}

@end

@implementation AppDelegate
@synthesize isReachable;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [NSThread sleepForTimeInterval:1];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //由于IOS8中定位的授权机制改变 需要进行手动授权
        CLLocationManager  *locationManager = [[CLLocationManager alloc] init];
        //获取授权认证
        [locationManager requestAlwaysAuthorization];
        [locationManager requestWhenInUseAuthorization];
    }
    
    [self startInternetReachability];
    
    ///分享
    [ShareSDK registerApp:@"164f650492dd2"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeGooglePlus)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
//                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             case SSDKPlatformTypeRenren:
//                 [ShareSDKConnector connectRenren:[RennClient class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
//             case SSDKPlatformTypeRenren:
////                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
////                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
////                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
////                                               authType:SSDKAuthTypeBoth];
//                 break;
//             case SSDKPlatformTypeGooglePlus:
////                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
////                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
////                                            redirectUri:@"http://localhost"
////                                               authType:SSDKAuthTypeBoth];
//                 break;
             default:
                 break;
         }
     }];
    
    ////百度定位
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:NAVI_TEST_APP_KEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"百度manager start failed!");
    }
    
    
    
    //初始化导航SDK
    [BNCoreServices_Instance initServices: NAVI_TEST_APP_KEY];
    [BNCoreServices_Instance startServicesAsyn:nil fail:nil];
//    [BNCoreServices NoteInstanceID];
    [WXApi registerApp:@"wxb4ba3c02aa476ea1" withDescription:@"微信接口测试"];

    return YES;
}
void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    
    NSLog(@"exception type 系统崩溃日志 : %@ \n crash reason : %@ \n call stack info : %@", name, reason, arr);
    NSString *crashLogInfo = [NSString stringWithFormat:@"exception type异常类型 : %@ \n crash reason崩溃的原因 : %@ \n call stack info得到当前调用栈信息 : %@", name, reason, arr];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://857576036@qq.com?subject=bug报告&body=感谢您的配合!"
                        "错误详情:%@",
                        crashLogInfo];
    NSURL *url = [NSURL URLWithString:UTF_8(urlStr)];
    [[UIApplication sharedApplication] openURL:url];
}

//监听网络
- (void)startInternetReachability
{
    //添加观察者
    [NOTIFICATION_CENTER addObserver:self
                            selector:@selector(checkNetworkStatus)
                                name:kReachabilityChangedNotification
                              object:nil];
    [defaultReachability() startNotifier];
    [self checkNetworkStatus];
}

//取消观察者
- (void)stopInternerReachability
{
    [NOTIFICATION_CENTER removeObserver:self
                                   name:kReachabilityChangedNotification
                                 object:nil];
}
#pragma mark - kReachabilityChangedNotification
- (void)checkNetworkStatus
{
    NetworkStatus internetStatus = [defaultReachability() currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            self.isReachable = NO;
            [NOTIFICATION_CENTER postNotificationName:NETWORK
                                               object:nil];
            //            if ([self.window.rootViewController isKindOfClass:[UINavigationController class]])
            //            {
            //                UIALERT(0, NETWORK, UIPINK);
            //            }
            //            if ([self.window.rootViewController isKindOfClass:[TabBarViewController class]])
            //            {
            //                UIALERT(1, NETWORK, UIPINK);
            //            }
            break;
        }
        case ReachableViaWiFi:
        case ReachableViaWWAN:
        {
            self.isReachable = YES;
            break;
        }
        default:
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// NOTE: 9.0以后使用新API接口 支付宝
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        //结果code为成功时，先校验签名，校验成功后做后续处理
        if([code isEqualToString:@"success"]) {
            
            //数据从NSDictionary转换为NSString
            NSDictionary *data;
            NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                               options:0
                                                                 error:nil];
            NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
            
            //判断签名数据是否存在
            if(data == nil){
                //如果没有签名数据，建议商户app后台查询交易结果
                return;
            }
            
            //验签证书同后台验签证书
            //此处的verify，商户需送去商户后台做验签
//            if([self verify:sign])
//            {
//                //支付成功且验签成功，展示支付成功提示
//            }
//            else
//            {
//                //验签失败，交易结果数据被篡改，商户app后台查询交易结果
//            }
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
        }
    }];

    return YES;
}
//微信回调
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        [NOTIFICATION_CENTER postNotificationName:@"weChatCallBack"
                                           object:self
                                         userInfo:@{@"code":[NSString stringWithFormat:@"%d", resp.errCode],
                                                    @"appointmentId":[USER_DEFAULT objectForKey:@"appointmentId"]}];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];

}
@end
