//
//  AllShareViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/19.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "AllShareViewController.h"

@interface AllShareViewController ()

@end

@implementation AllShareViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏TabBar
    [self.tabBarController.tabBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    [[HttpHelper sharedInstance]removeListener:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addBackBtnWithImageNormal:@"back" fuction:@selector(backBtn)];
    _img.image = [self QRcodeWithText:[USER_DEFAULT objectForKey:PHONE] size:150.0];
    //如果还想加上阴影，就在ImageView的Layer上使用下面代码添加阴影
    _img.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
    
    _img.layer.shadowRadius=1;//设置阴影的半径
    
    _img.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
    
    _img.layer.shadowOpacity=0.3;
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    //    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    NSDictionary *successDic = [notify userInfo][key];
    
}

- (void)failure:(NSNotification *)notify
{
        [self dismissIndicatorView];
        [self showAlertWithPoint:0
                            text:[notify userInfo][FAILURE]
                           color:UIPINK];
    
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)share:(id)sender {
    //1、创建分享参数
    NSArray* imageArray = @[@"shareImg.png"];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:[UIImage imageNamed:[imageArray objectAtIndex:0]]
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }];
    }

}
@end
