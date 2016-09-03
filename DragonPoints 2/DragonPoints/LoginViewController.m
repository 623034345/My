//
//  LoginViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/28.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    //    [self hideNavigationBarLine];
    [self.tabBarController.tabBar setHidden:YES];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = UIWHITE;
//    fieldName = [[UITextField alloc] initWithFrame:CGRectMake(20, 104, SCREEN_WIDTH - 40, 55)];
//    fieldName.placeholder = @"               输入手机号或用户名";
//    fieldName.delegate =self;
//    fieldName.layer.borderWidth = 1.0f;
//    fieldName.layer.cornerRadius = 5;
//    fieldName.layer.borderColor = UIBLACK.CGColor;
//    [self.view addSubview:fieldName];
//    
//    touImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 30, 30)];
//    touImg.image = [UIImage imageNamed:@"name"];
//    [fieldName addSubview:touImg];
//    
//    fieldPows = [[UITextField alloc] initWithFrame:CGRectMake(20, 180, SCREEN_WIDTH - 40, 55)];
//    fieldPows.placeholder = @"               输入密码";
//    fieldPows.delegate =self;
//    [fieldPows setSecureTextEntry:YES];
//    fieldPows.layer.borderWidth = 1.0f;
//    fieldPows.layer.cornerRadius = 5;
//    fieldPows.layer.borderColor = UIBLACK.CGColor;
//    [self.view addSubview:fieldPows];
//    suoImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 30, 30)];
//    suoImg.image = [UIImage imageNamed:@"pow"];
//    [fieldPows addSubview:suoImg];
//    
//    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    loginBtn.frame = CGRectMake(20, 252, SCREEN_WIDTH - 40, 55);
//    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
//    [loginBtn setBackgroundImage:[UIImage imageNamed:@"bigBtn"] forState:UIControlStateNormal];
//    [loginBtn addTarget:self action:@selector(logGo) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginBtn];
//    
//    UIButton *zhaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    zhaoBtn.frame = CGRectMake(40, 310, 80, 50);
//    [zhaoBtn setTitle:@"找回密码" forState:UIControlStateNormal];
//    [zhaoBtn setTitleColor:UIBLACK forState:UIControlStateNormal];
//    [zhaoBtn addTarget:self action:@selector(zhaoBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:zhaoBtn];
//    
//    UIButton *zhuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    zhuBtn.frame = CGRectMake(SCREEN_WIDTH - 130, 310, 80, 50);
//    [zhuBtn setTitleColor:UIBLACK forState:UIControlStateNormal];
//    [zhuBtn setTitle:@"注册" forState:UIControlStateNormal];
//    [zhuBtn addTarget:self action:@selector(zhuBtn) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:zhuBtn];
    [self addBackBtnWithImageNormal:@"back" fuction:@selector(backBtn)];
}
-(void)backBtn
{
    if (_isFrist) {
        ViewController *vc = [[ViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];

    }
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([key isEqualToString:LOGIN]) {
        NSDictionary *successDic = [notify userInfo][LOGIN];
        NSLog(@"%@",successDic);
        //    NSString *rt_code = successDic[@"rt_code"];
        NSString *rt_msg = successDic[@"msg"];
        NSString *rt_code =successDic[@"code"];
        if ([rt_code isEqualToString:@"1"]) {
            [USER_DEFAULT setObject:successDic[@"memberId"]
                             forKey:USERID];
            [USER_DEFAULT setObject:_fieldName.text
                             forKey:PHONE];
            [self showAlertWithPoint:0
                                text:rt_msg
                               color:UICYAN];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (_isFrist) {
//                    ViewController *vc = [[ViewController alloc] init];
//                    [self.navigationController pushViewController:vc animated:YES];
//                }
//                else
//                {
                    [self.navigationController popViewControllerAnimated:YES];
//                }
            });
        }
        else
        {
            [self showAlertWithPoint:0
                                text:rt_msg
                               color:UIPINK];
        }
    }

    
    
}

- (void)failure:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [self showAlertWithPoint:0
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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

- (IBAction)login:(id)sender {
    if (NULL_STR(_fieldName.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                    text:@"用户名不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    if (NULL_STR(_fieldPow.text) && !NULL_STR(_fieldName.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                    text:@"密码不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    else
    {
        [[HttpHelper sharedInstance] loginWithUserName:_fieldName.text
                                              password:_fieldPow.text];
    }

}

- (IBAction)zhaoBtn:(id)sender {
    ForgetViewController *forGet = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:forGet animated:YES];
}

- (IBAction)zhuBtn:(id)sender {
    RegistrationViewController *registra =[[RegistrationViewController alloc] init];
    [self.navigationController pushViewController:registra animated:YES];
}
@end
