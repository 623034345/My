//
//  UIViewController+Base.m
//  ForNowIosSupper
//
//  Created by fornowIOS on 15/8/6.
//  Copyright (c) 2015年 fornowIOS. All rights reserved.
//

#import "UIViewController+Base.h"
#import "MBProgressHUD.h"
#import "ActivityIndicatorView.h"
#import "InfoAlert.h"
#import "EffectLabel.h"
#import <objc/runtime.h>

static const void *HUDKEY = &HUDKEY;
static const void *INDICATORKEY = &INDICATORKEY;
static const void *ALERTKEY = &ALERTKEY;
static const void *BGVIEWKEY = &BGVIEWKEY;
static const void *WIFIVIEW = &WIFIVIEW;

@implementation UIViewController (Base)

//圆形菊花
- (MBProgressHUD *)hud
{
    return objc_getAssociatedObject(self, HUDKEY);
}

- (void)setHud:(MBProgressHUD *)hud
{
    objc_setAssociatedObject(self, HUDKEY, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//条形菊花
- (EffectLabel *)indicator
{
    return objc_getAssociatedObject(self, INDICATORKEY);
}

- (void)setIndicator:(EffectLabel *)indicator
{
    objc_setAssociatedObject(self, INDICATORKEY, indicator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//带提示弹窗的对话框
- (InfoAlert *)alert
{
    return objc_getAssociatedObject(self, ALERTKEY);
}

- (void)setAlert:(InfoAlert *)alert
{
    objc_setAssociatedObject(self, ALERTKEY, alert, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//遮罩层
- (UIView *)bgView
{
    return objc_getAssociatedObject(self, BGVIEWKEY);
}

- (void)setBgView:(UIView *)bgView
{
    objc_setAssociatedObject(self, BGVIEWKEY, bgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//无网络
- (UIView *)wifiView
{
    return objc_getAssociatedObject(self, WIFIVIEW);
}

-(void)setbtn:(UIView *)view
{
    objc_setAssociatedObject(self, WIFIVIEW, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//去除NaviagtionBar下的黑线
- (void)hideNavigationBarLine
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self.navigationController.navigationBar setTranslucent:YES];
        [self.navigationController.navigationBar setTitleTextAttributes:
         
         
         @{NSFontAttributeName:[UIFont systemFontOfSize:19],
           
           
           NSForegroundColorAttributeName:UIWHITE}];
        [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
        {
            if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")])
            {
                UIView *view = (UIView *)obj;
                view.backgroundColor = UICOLOR_HEX(0xda202e);//0xa71520
;
                view.hidden = YES;
            }
            if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")])
            {
                UIView *view = (UIView *)obj;
                view.hidden = YES;
                view.backgroundColor = UICLEAR;
            }
            if ([obj isKindOfClass:NSClassFromString(@"UIImageView")])
            {
                [[(UIImageView *)obj subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                {
                    if ([obj isKindOfClass:[UIImageView class]])
                    {
                        UIImageView *imageView = (UIImageView *)obj;
                        imageView.hidden = YES;
                    }
                    if ([obj isKindOfClass:NSClassFromString(@"_UIBackdropView")])
                    {
                        UIView *view = (UIView *)obj;
                        view.hidden = YES;
                    }
                }];
            }
        }];
    }
}

//调整ScrollView位置
- (void)adjustsScrollViewInsets
{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)])
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

//带图片的返回按钮
- (void)addBackBtnWithImageNormal:(NSString *)normalStr
                          fuction:(SEL)function;
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.bounds = CGRectMake(0, 0, 30, 30);
    [backBtn setImage:[UIImage imageNamed:normalStr]
                       forState:UIControlStateNormal];

    [backBtn addTarget:self
                action:function
      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBtnItem;
}

//带图片的下一步按钮
- (void)addNextBtnWithImageNormal:(NSString *)normalStr
                          fuction:(SEL)function
{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.bounds = CGRectMake(0, 0, 22, 22);
    [saveBtn setBackgroundImage:[UIImage imageNamed:normalStr]
                       forState:UIControlStateNormal];
    [saveBtn addTarget:self
                action:function
      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = saveBtnItem;
}

//带文字的下一步按钮
- (void)addNextBtnWithTitle:(NSString *)titleStr
                    fuction:(SEL)function
{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.backgroundColor = UICLEAR;
    saveBtn.bounds = CGRectMake(0, 0, 49, 44);
    [saveBtn.titleLabel setFont:UIFONT(16)];
    [saveBtn setTitle:titleStr
             forState:UIControlStateNormal];
    [saveBtn setTitle:titleStr
             forState:UIControlStateHighlighted];
    [saveBtn setTitleColor:UIWHITE
                  forState:UIControlStateNormal];
    [saveBtn setTitleColor:UIColorWithRGB(239, 239, 239)
                  forState:UIControlStateHighlighted];
    [saveBtn addTarget:self
                action:function
      forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveBtnItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    self.navigationItem.rightBarButtonItem = saveBtnItem;
}

//添加轻按手势
- (void)addTapRecognizer:(SEL)fuction
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:fuction];
    [self.view addGestureRecognizer:tap];
}

//显示圆形菊花
- (void)showHudView
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:KEYWINDOW];
    hud.labelText = @"请等待...";
    hud.labelFont = UIFONT(15);
    hud.opacity = 0.5;
    [KEYWINDOW addSubview:hud];
    [self setHud:hud];
    [hud show:YES];
}

//移除圆形菊花
- (void)dismissHudView
{
    [[self hud] hide:YES];
}

//显示条形菊花
- (void)showIndicatorView
{
    if (![[self indicator] window])
    {
        EffectLabel *indicator = [[EffectLabel alloc] initWithFrame:CGRectMake(0, 100, 300, 60)];
        indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        indicator.font = UIFONT(20);
        indicator.text = @"掌创天下";
        
        indicator.textColor = UIGRAY;
        indicator.effectColor = UICOLOR_HEX(0xf0f1f6);
        indicator.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        UIView *bgView = [[UIView alloc] initWithFrame:SCREEN_BOUNDS];
        [self.view addSubview:bgView];
        [bgView addSubview:indicator];
        [self setBgView:bgView];
        [self setIndicator:indicator];
        [indicator startAnimating];
    }
}

//表格中使用
- (void)showIndicatorViewWithViewHeight:(CGFloat)height
{
    EffectLabel *indicator = [[EffectLabel alloc] initWithFrame:CGRectMake(0, 0, 300, 160)];
    indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    indicator.font = UIFONT(20);
    indicator.text = @"掌创天下";
    indicator.textColor = UIBLUE;
    indicator.effectColor = UIWHITE;
    indicator.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, height)];
    [self.view addSubview:bgView];
    [bgView addSubview:indicator];
    [self setBgView:bgView];
    [self setIndicator:indicator];
    [indicator startAnimating];
}

//移除条形菊花
- (void)dismissIndicatorView
{
    if ([[self indicator] window])
    {
        [[self indicator] stopAnimating];
        [[self bgView] removeFromSuperview];
        
    }
}

//显示带提示弹窗的对话框
- (void)showAlertWithPoint:(int)flag
                      text:(NSString *)textStr
                     color:(UIColor *)color
{
    InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:flag
                                                                text:textStr
                                                               color:color];
    if (![[self alert] window])
    {
        [KEYWINDOW addSubview:infoAlert];
        [self setAlert:infoAlert];
        [infoAlert showView];
    }
}

//移除带提示弹窗的对话框
- (void)dismissView
{
    if ([self alert])
    {
        [[self alert] removeFromSuperview];
    }
}

//添加无网络
-(void)addWifiBtnWithfuction:(SEL)function
{
    if (![[self wifiView] window])
    {
        UIView *wifiView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, CONTENT_VIEW_HEIGHT_NO_TAB_BAR)];
        [self.view addSubview:wifiView];
        UIButton *wifiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        wifiBtn.frame = wifiView.bounds;
        [wifiBtn setBackgroundImage:[UIImage imageNamed:@"proload_wifi"]
                           forState:UIControlStateNormal];
        [wifiBtn setBackgroundImage:[UIImage imageNamed:@"proload_wifi"]
                           forState:UIControlStateHighlighted];
        [wifiBtn addTarget:self
                    action:function
          forControlEvents:UIControlEventTouchUpInside];
        [wifiView addSubview:wifiBtn];
        [self setbtn:wifiView];
    }
}

//移除无网络
-(void)removeWifiBtn
{
    if ([[self wifiView] window])
    {
        [[self wifiView] removeFromSuperview];
    }
}

//网络状态
- (BOOL)isReachable
{
    return [APP_DELEGATE_INSTANCE isReachable];
}

//添加网络连接观察者
- (void)addObserver:(id)obj
           function:(SEL)fuction
{
    [NOTIFICATION_CENTER addObserver:obj
                            selector:fuction
                                name:NETWORK
                              object:nil];
}

//移除网络连接观察者
- (void)removeObserver:(id)obj
{
    [NOTIFICATION_CENTER removeObserver:obj
                                   name:NETWORK
                                 object:nil];
}

#pragma mark - 时间处理
//时间间隔
- (NSString *)dayHourMinuteWith:(NSString *)gmtTime
{
    if (gmtTime.length > 10) {
        gmtTime = [gmtTime substringToIndex:10];
    }
    NSDate *appointmentTime = [NSDate dateWithTimeIntervalSince1970:[gmtTime intValue]];
    NSTimeInterval date = [appointmentTime timeIntervalSince1970]*1;
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970]*1;
    NSTimeInterval cha = date - now;//时间差，秒数
    int days = (int)cha/(3600*24);
    int hours = (int)cha%(3600*24)/3600;
    int minute = (int)cha%3600/60;
    int second = (int)cha%60;
    NSString *dateContent;
    if (days <= 0 && hours <= 0 && minute <= 0 && second <= 0)
    {
        dateContent = @"000";
    }
    else
    {
        dateContent = [[NSString alloc] initWithFormat:@"%i 天 %i小时 %i分钟", days, hours, minute + 1];
    }
    return dateContent;
}

//距离预约时间分钟
- (int)minuteWith:(NSString *)gmtTime
{
    if (gmtTime.length > 10)
    {
        gmtTime = [gmtTime substringToIndex:10];
    }
    NSDate *appointmentTime = [NSDate dateWithTimeIntervalSince1970:[gmtTime intValue]];
    NSTimeInterval date = [appointmentTime timeIntervalSince1970]*1;
    NSDate *nowDate = [NSDate date];
    NSTimeInterval now = [nowDate timeIntervalSince1970]*1;
    NSTimeInterval cha = date - now;//时间差，秒数
    int minute = (int)cha/60;
    return minute;
}
//带提示框的弹窗
-(void)alertControllerQue:(UIAlertAction*)seleced prompt:(NSString *)prompt msg:(NSString *)msgStr
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:prompt message:msgStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action)
    {
        
    }];
    
//    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
////        [alert addTapRecognizer:seleced];
//        [alert addAction:seleced];
//
//        
//    }];
    [alert addAction:cancle];
    [alert addAction:seleced];
    [self presentViewController:alert animated:YES completion:nil];
}
//生成二维码
- (UIImage *)QRcodeWithText:(NSString *)textStr size:(NSInteger )size
{
    //二维码滤镜
    CIFilter *filter=[CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //恢复滤镜的默认属性
    [filter setDefaults];
    
    //输入内容
//    NSString *string;
//    if (_textField.text.length == 0 ||_textField.text == nil) {
//        string = @"www.baidu.com";
//    }else{
//        string = _textField.text;
//    }
    //将字符串转换成NSData
    NSData *data=[textStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //通过KVO设置滤镜inputmessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    //获得滤镜输出的图像
    CIImage *outputImage=[filter outputImage];
    
    //将CIImage转换成UIImage,并放大显示
    UIImage *image=[self createNonInterpolatedUIImageFormCIImage:outputImage withSize:size];
    
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
//    _imageView.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
//    
//    _imageView.layer.shadowRadius=1;//设置阴影的半径
//    
//    _imageView.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
//    
//    _imageView.layer.shadowOpacity=0.3;
    return image;
    
}

//改变二维码大小
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    
    CGContextRelease(bitmapRef);
    
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
    
}
//触摸表
-(void)touchTable:(UITableView *)table
commentTableViewTouchInSide:(SEL)commentTableViewTouchInSide
{
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:commentTableViewTouchInSide];
    tableViewGesture.numberOfTapsRequired = 1;
    tableViewGesture.cancelsTouchesInView = NO;
    [table addGestureRecognizer:tableViewGesture];
}
-(void)sharedWithcontArr:(NSArray *)contArr
{
    //1、创建分享参数
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (contArr) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:[UIImage imageNamed:[contArr objectAtIndex:0]]
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                               //成功
                           case SSDKResponseStateSuccess:
                           {
                               [self showAlertWithPoint:1 text:@"分享成功" color:UICYAN];
                               break;
                           }
                               //失败
                           case SSDKResponseStateFail:
                           {
                               [self showAlertWithPoint:1 text:@"分享失败" color:UIPINK];

                               break;
                           }
                           default:
                               break;
                       }
                   }];
        
    }


}
@end
