//
//  SettingHeard.h
//  DragonPoints
//
//  Created by shangce on 16/8/25.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#ifndef SettingHeard_h
#define SettingHeard_h
#import "LoginViewController.h"
#import "UIViewController+Base.h"
#import "NavigationViewController+StatusBarStyle.h"
#import "ScanQRcode.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "HttpHelper.h"
#import "ActivityIndicatorView.h"
#import "EffectLabel.h"
#import "MBProgressHUD.h"
#import "GlobalCenter.h"
#import "MJRefresh.h"
#import "InfoAlert.h"
#import "InfoActionSheet.h"
#import "LabelAlert.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "Masonry.h"
#import "MWPhotoBrowser.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
//微信支付/分享/收藏
#import "WXApi.h"

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"



#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件


#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
#define APP_DELEGATE_INSTANCE \
((AppDelegate *)([UIApplication sharedApplication].delegate))

#define KEYWINDOW \
[UIApplication sharedApplication].keyWindow

#define KEYWINDOW_VIEW \
KEYWINDOW.viewForBaselineLayout

#define SYSTEM_VERSION_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) \
([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_OS_7_OR_LATER \
SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")

#define IS_OS_8_OR_LATER \
SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define IS_OS_9_OR_LATER \
SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")

#define SCREEN_BOUNDS \
[UIScreen mainScreen].bounds

#define SCREEN_WIDTH \
(SCREEN_BOUNDS.size.width)

#define SCREEN_HEIGHT \
(SCREEN_BOUNDS.size.height)

#define SCREEN_SIZE \
CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)

#define SCREEN_6P_SIZE CGSizeMake(414, 736)

#define IS_WIDESCREEN4S \
(fabs((double)SCREEN_HEIGHT - (double)480) < __DBL_EPSILON__)

#define IS_WIDESCREEN5 \
(fabs((double)SCREEN_HEIGHT - (double)568) < __DBL_EPSILON__)

#define IS_WIDESCREEN6 \
(fabs((double)SCREEN_HEIGHT - (double)667) < __DBL_EPSILON__)

#define IS_WIDESCREEN6P \
(fabs((double)SCREEN_HEIGHT - (double)736) < __DBL_EPSILON__)

#define IS_IPHONE \
([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] || [[[UIDevice currentDevice] model] isEqualToString:@"iPhone Simulator"])

#define IS_IPOD \
([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

#define IS_IPHONE4S \
(IS_IPHONE && IS_WIDESCREEN4S)

#define IS_IPHONE5 \
(IS_IPHONE && IS_WIDESCREEN5)

#define IS_IPHONE6 \
(IS_IPHONE && IS_WIDESCREEN6)

#define IS_IPHONE6P \
(IS_IPHONE && IS_WIDESCREEN6P)

#define STATUS_BAR_HEIGHT               20

#define BAR_ITEM_WIDTH_HEIGHT           30

#define NAVIGATION_BAR_HEIGHT           44

#define TAB_TAB_HEIGHT                  49

#define TABLE_ROW_HEIGHT                44

#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define CONTENT_VIEW_HEIGHT_NO_TAB_BAR \
(SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)

#define CONTENT_VIEW_HEIGHT_TAB_BAR \
(CONTENT_VIEW_HEIGHT_NO_TAB_BAR - TAB_TAB_HEIGHT)
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0f green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0f blue:((float)(rgbValue & 0xFF)) / 255.0f alpha:1.0f]

#define UIColorWithRGB(r,g,b) \
[UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f]

#define UIColorWithRGBA(r,g,b,a) \
[UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]

#define UICOLOR_HEX(hexColor) \
[UIColor colorWithRed: (((hexColor >> 16) & 0xFF)) / 255.0f green: (((hexColor >> 8) & 0xFF)) / 255.0f blue: ((hexColor & 0xFF)) / 255.0f alpha:1.0f]

#define UICOLOR_HEXA(hexColor, alp) [UIColor colorWithRed: (((hexColor >> 16) & 0xFF))/255.0f \
green: (((hexColor >>  8) & 0xFF))/255.0f \
blue: ((hexColor & 0xFF))/255.0f \
alpha: alp]

#define USER_DEFAULT \
[NSUserDefaults standardUserDefaults]
#define NOTIFICATION_CENTER \
[NSNotificationCenter defaultCenter]

#define VALID_CODE \
[[GlobalCenter sharedInstance] dataStr]

#define TRIMMING_STR(str) \
[[GlobalCenter sharedInstance] isTrimmingStr:str]
#define FONT(float) \
[UIFont systemFontOfSize:float]
#define SPLIT_STR(first, second, split) \
[[GlobalCenter sharedInstance] firstStr:first \
secondStr:second \
splitStr:split]

#define NULL_STR(str) \
[[GlobalCenter sharedInstance] isNullStr:str]

#define MOBILE_STR(str) \
[[GlobalCenter sharedInstance] isMobileStr:str]

#define NICKNAME_STR(str) \
[[GlobalCenter sharedInstance] isNicknameStr:str]

#define PASSWORD_STR(str) \
[[GlobalCenter sharedInstance] isPasswordStr:str]

#define MONEYCOUNT_STR(str) \
[[GlobalCenter sharedInstance] charkMoneyStr:str]

#define CODE_STR(str) \
[[GlobalCenter sharedInstance] isCodeStr:str]
#define UTF_8(str) \
[[GlobalCenter sharedInstance] utfstr:str]
#define COMMAS_STR(first, second) \
SPLIT_STR(first, second, @",")

#define NONE_STR \
SPLIT_STR(@"", @"", @",")

#define UIBLACK \
UICOLOR_HEX(0x4a4a4a)

#define UIGRAY \
UICOLOR_HEX(0xa6a6a6)

#define UIBLUE \
UICOLOR_HEX(0x00a0e9)

#define UIGREEN \
UICOLOR_HEX(0x8fc31f)

#define UICYAN \
UICOLOR_HEX(0x00a0e9)

#define UIRED \
UICOLOR_HEX(0xFF4655)

#define UIPINK \
UICOLOR_HEX(0xff5d5d)

#define UITABLE_LINE \
UICOLOR_HEX(0xf0f1f6)

#define UIWHITE \
[UIColor whiteColor]

#define UICLEAR \
[UIColor clearColor]

#define UIORANGE_NORMAL \
UIColorWithRGB(243, 151, 2)

#define UIORANGE_SELECTED \
UIColorWithRGB(238, 132, 10)

#define UIRED_NORMAL \
UIColorWithRGB(255, 107, 107)

#define UIRED_HIGHLIGHTED \
UIColorWithRGB(229, 97, 97)

#define UIBLUE_NORMAL \
UIColorWithRGB(25, 176, 249)

#define UIBLUE_HIGHLIGHTED \
UIColorWithRGB(19, 141, 199)
#define PI 3.1415926

#define UIFONT(font) \
[UIFont fontWithName:@"MicrosoftYaHei" size:font]
#define SUCCESS @"success"
#define FAILURE @"failure"
#define NETWORK @"network"
#define CODE @"code"
#define DATAS @"datas"
#define APP_NAME \
@"fornowSenior"
#define ISLOGIN @"isLogin"
#import "HttpHelper.h"
//登录注册
#define LOGIN @"login"
#define RIGISTRATION @"rigistration"
#define FORGET @"forget"
#define SENDSMS @"sendsms"
#define USERID @"userId"
#define PHONE @"phone"
#define SHOPPERID @"shopperId"
///* 首页*/
#define HOME @"home"
#define MORE @"more"
#define CLASSL @"classl"
#define IMAGEARR @"imagearr"

///////* 商家 *//////////////
#define SHOPS @"shops"
#define SHOPSDAIL @"shopsdail"
#define OFSHOPS @"ofshops"
#define EVALUATE @"evaluate"
#define BUYNOWUSE @"buynowuse"
#define BUYINUSE @"buyinuse"

#define PREPARETOPAY @"preparetopay"

///////* 我的 *//////////////
#define GRADE @"grade"
#define CHANGEP @"changep"
#define TRADEP @"tradep"
#define COINDETAIL @"coindetail"
#define BEAND @"beand"
#define SYSTEM @"system"
#define BALANCE @"balance"
#define PRESALE @"presala"
#define PAYCOIN @"paycoin"
#define PAYCOINSUCCESS @"paycoinsuccess"
#define COINTODAIL @"cointodail"
#define BANKCARD @"bankcard"
#define ZHIFUBAO @"zhifubao"
#define ASSETS @"assets"
#define DRAWBEAN @"drawbean"
#define DRAWBEA @"drawbea"
#define MYMAIN @"mymain"
#define SPENDING @"spending"
#define UPNICKNAME @"upnickname"
#define MUTUAL @"mutual"
#define OPENSHOPPER @"openshopper"
#define SHOPPERMINE @"shoppermine"
#define SHOPORDERLIST @"shoporderlist"
#define CANCELORDER @"cancelorder"
#define AFTERCONSUME @"afterconsume"
#define AFTERCONSUME1 @"afterconsume1"
#define SCANREDEEM @"scanredeemcode"
#define CUSTOMERCOMMENT @"coustomercomment"


#define SERVER_NAME \
@"http://117.78.35.158:8080/"
//117.78.46.76
//#define SERVER_NAME \
//@"http://117.78.46.76:8080/"

#endif /* SettingHeard_h */
