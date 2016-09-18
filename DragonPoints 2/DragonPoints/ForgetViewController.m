//
//  ForgetViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/28.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "ForgetViewController.h"

@interface ForgetViewController ()

@end

@implementation ForgetViewController
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
    self.navigationItem.title = @"找回密码";
    self.view.backgroundColor = UIWHITE;
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backUp)];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.bounds = CGRectMake(0, 0, 30, 30);
//    [backBtn setImage:[UIImage imageNamed:@"back"]
//             forState:UIControlStateNormal];
//    
//    [backBtn addTarget:self
//                action:@selector(backUp)
//      forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = backBtnItem;
}
-(void)backUp
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
//获取验证码
- (IBAction)hqBtn:(id)sender
{
    if (NULL_STR(_fieldName.text)) {
        [self showAlertWithPoint:0
                            text:@"手机号不能为空"
                           color:UIPINK];
    }
    
    else
    {
        if ([[GlobalCenter sharedInstance] isMobileStr:_fieldName.text])
        {
            [[HttpHelper sharedInstance] sendSmsWithtele:_fieldName.text];
            
        }
        else
        {
            [self showAlertWithPoint:0
                                text:@"请输入正确的手机号"
                               color:UIPINK];
        }
        
    }
}
//查看密码
- (IBAction)lookBtn:(id)sender
{
    [self.fieldPow setSecureTextEntry:NO];
}
//完成
- (IBAction)wcBtn:(id)sender
{
    if (NULL_STR(_fieldName.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                    text:@"用户名不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
        return;
    }
    if (NULL_STR(_fieldYan.text) && !NULL_STR(_fieldName.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                    text:@"验证码不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
        return;
    }
    if (![[GlobalCenter sharedInstance] isPasswordStr:_fieldPow.text]) {
        [self showAlertWithPoint:0 text:@"密码不少于6位且最少有一个数字" color:UIPINK];
    }

    if (NULL_STR(_fieldPow.text) && !NULL_STR(_fieldName.text) && !NULL_STR(_fieldYan.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
                                                                    text:@"密码不能为空"
                                                                   color:UIRED];
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
        return;
    }
    if (!NULL_STR(_fieldPow.text) && !NULL_STR(_fieldName.text) && !NULL_STR(_fieldYan.text) && [[GlobalCenter sharedInstance] isPasswordStr:_fieldPow.text])
    {
        [[HttpHelper sharedInstance] forGetWithregTele:_fieldName.text
                                                   Pwd:UTF_8(_fieldPow.text)
                                                smsStr:_fieldYan.text];
    }

}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([FORGET isEqualToString:key]) {
        NSDictionary *successDic = [notify userInfo][FORGET];
        NSLog(@"%@",successDic);
        NSString *rt_msg = successDic[@"msg"];
        if ([rt_msg isEqualToString:@"1"]) {
            [self showAlertWithPoint:0
                                text:rt_msg
                               color:UICYAN];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        else
        {
            [self showAlertWithPoint:0
                                text:rt_msg
                               color:UIPINK];
        }
    }
    if ([key isEqualToString:SENDSMS])
    {
        NSDictionary *successDic = [notify userInfo][SENDSMS];
        NSLog(@"%@",successDic);
        NSString *rt_msg = successDic[@"msg"];
        NSString *msg = successDic[@"code"];
        if ([msg isEqualToString:@"1"]) {
            [self showAlertWithPoint:0
                                text:rt_msg
                               color:UICYAN];
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
@end
