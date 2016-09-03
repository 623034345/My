//
//  PwdSettingViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/17.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "PwdSettingViewController.h"

@interface PwdSettingViewController ()

@end

@implementation PwdSettingViewController
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
    dataSource = [NSMutableArray array];
    dataSource1 = [NSMutableArray array];
    
    self.view.backgroundColor = UIWHITE;
    self.navigationItem.title = @"设置交易密码";
    
    teleTX = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, SCREEN_WIDTH - 80, 30)];
    teleTX.text = [USER_DEFAULT objectForKey:PHONE];
    [self.view addSubview:teleTX];
    
    smsTX = [[UITextField alloc] initWithFrame:CGRectMake(40, 110, 200, 50)];
    smsTX.placeholder = @"请输入验证码";
    smsTX.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:smsTX];
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(250, 110, 100, 50);
    [btn4 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn4 setTitleColor:UIRED forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(acquire:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];

    
    topTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    topTX.hidden = YES;
    topTX.keyboardType = UIKeyboardTypeNumberPad;
    [topTX addTarget:self action:@selector(txchange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:topTX];
    
    aNewTX1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 290, self.view.frame.size.width, 50)];
    aNewTX1.hidden = YES;
    aNewTX1.keyboardType = UIKeyboardTypeNumberPad;
    [aNewTX1 addTarget:self action:@selector(txchangeL:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:aNewTX1];
    
    //进入界面，topTX成为第一响应
    [topTX becomeFirstResponder];
    
    for (int i = 0; i < 6; i++)
    {
        UITextField *pwdLabel = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -300)/2+i*50, 200, 50, 50)];
        pwdLabel.layer.borderColor = [UIColor blackColor].CGColor;
        pwdLabel.enabled = NO;
        pwdLabel.textAlignment = NSTextAlignmentCenter;//居中
        pwdLabel.secureTextEntry = YES;//设置密码模式
        pwdLabel.layer.borderWidth = 1;
        [self.view addSubview:pwdLabel];
        
        [dataSource addObject:pwdLabel];
    }
    
    for (int i = 0; i < 6; i++)
    {
        UITextField *pwdLabel = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -300)/2+i*50, 290, 50, 50)];
        pwdLabel.layer.borderColor = [UIColor blackColor].CGColor;
        pwdLabel.enabled = NO;
        pwdLabel.textAlignment = NSTextAlignmentCenter;//居中
        pwdLabel.secureTextEntry = YES;//设置密码模式
        pwdLabel.layer.borderWidth = 1;
        [self.view addSubview:pwdLabel];
        
        [dataSource1 addObject:pwdLabel];
    }
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(40, 165, SCREEN_WIDTH - 100, 30)];
    lab.text = @"请输入新密码";
    [self.view addSubview:lab];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 255, SCREEN_WIDTH - 100, 30)];
    lab1.text = @"请再次输入新密码";
    [self.view addSubview:lab1];

    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 200, self.view.frame.size.width, 50);
    [btn1 addTarget:self action:@selector(huo:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 1;
    [self.view addSubview:btn1];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 290, self.view.frame.size.width, 50);
    [btn3 addTarget:self action:@selector(huo:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag = 2;
    [self.view addSubview:btn3];
    
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn setBackgroundColor:UIRED];
    [btn addTarget:self action:@selector(sumitBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
}
//获取验证码
-(void)acquire:(UIButton *)button
{
    [[HttpHelper sharedInstance] sendSmsWithtele:[USER_DEFAULT objectForKey:PHONE]];
    [button setTitle:@"重新获取" forState:UIControlStateNormal];

}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)huo:(UIButton *)button
{
    switch (button.tag) {
        case 1:
        {
            [topTX becomeFirstResponder];
            
        }
            break;
        case 2:
        {
            [aNewTX1 becomeFirstResponder];
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark 文本框内容改变
- (void)txchange:(UITextField *)tx
{
    [topTX becomeFirstResponder];
    
    NSString *password = tx.text;
    
    if (password.length == dataSource.count)
    {
        [tx resignFirstResponder];//隐藏键盘
    }
    
    for (int i = 0; i < dataSource.count; i++)
    {
        UITextField *pwdtx = [dataSource objectAtIndex:i];
        if (i < password.length)
        {
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdtx.text = pwd;
            
        }
        
    }
    
    if (password.length == 6)
    {
        pows1 = password;
        
        [aNewTX1 becomeFirstResponder];
        
    }
}
- (void)txchangeL:(UITextField *)tx
{
    [aNewTX1 becomeFirstResponder];
    
    NSString *password = tx.text;
    
    if (password.length == dataSource1.count)
    {
        [tx resignFirstResponder];//隐藏键盘
    }
    
    for (int i = 0; i < dataSource1.count; i++)
    {
        UITextField *pwdtx = [dataSource1 objectAtIndex:i];
        if (i < password.length)
        {
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdtx.text = pwd;
        }
        
    }
    
    if (password.length == 6)
    {
        pows2 = password;
        
    }
}

-(void)sumitBtn
{
    if (pows2 != pows1) {
        [self showAlertWithPoint:1 text:@"两次密码输入不一致" color:UIPINK];

    }
    if (pows2.length<6) {
        [self showAlertWithPoint:1 text:@"请确认输入交易密码" color:UIPINK];
    }
    if (NULL_STR(smsTX.text)) {
        [self showAlertWithPoint:1 text:@"验证码不能为空" color:UIPINK];

    }
    else
    {
        [[HttpHelper sharedInstance] tradePowsWithRegtele:[USER_DEFAULT objectForKey:PHONE]
                                                 transPwd:pows2
                                                  smsCode:smsTX.text];
    }
   
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    NSDictionary *successDic = [notify userInfo][key];
    if ([key isEqualToString:TRADEP]) {
        NSString *code =successDic[@"code"];
        NSString *msg =successDic[@"msg"];
        if ([code isEqualToString:@"1"]) {
            [self showAlertWithPoint:1 text:msg color:UICYAN];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        if ([code isEqualToString:@"-1"]) {
            [self showAlertWithPoint:1 text:msg color:UIPINK];
            
        }
        if ([code isEqualToString:@"-2"]) {
            [self showAlertWithPoint:1 text:msg color:UIPINK];
        }
        if ([code isEqualToString:@"-3"]) {
            [self showAlertWithPoint:1 text:msg color:UIPINK];
        }
    }

    if ([key isEqualToString:SENDSMS])
    {
        NSDictionary *successDic = [notify userInfo][SENDSMS];
        NSLog(@"%@",successDic);
        NSString *rt_msg = successDic[@"msg"];
        NSString *msg = successDic[@"code"];
        if ([msg isEqualToString:@"1"]) {
            [self showAlertWithPoint:1
                                text:rt_msg
                               color:UICYAN];
        }
        else
        {
            [self showAlertWithPoint:1
                                text:rt_msg
                               color:UIPINK];
        }
    }

    
}

- (void)failure:(NSNotification *)notify
{
        [self dismissIndicatorView];
        [self showAlertWithPoint:1
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

@end
