//
//  TradePowsViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/10.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "TradePowsViewController.h"

@interface TradePowsViewController ()

@end

@implementation TradePowsViewController
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
    dataSource2 = [NSMutableArray array];

    self.view.backgroundColor = UIWHITE;
    self.navigationItem.title = @"修改交易密码";
    topTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    topTX.hidden = YES;
    topTX.keyboardType = UIKeyboardTypeNumberPad;
    [topTX addTarget:self action:@selector(txchange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:topTX];
    
    aNewTX1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 50)];
    aNewTX1.hidden = YES;
    aNewTX1.keyboardType = UIKeyboardTypeNumberPad;
    [aNewTX1 addTarget:self action:@selector(txchangeL:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:aNewTX1];
    
    aNewTX2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 260, self.view.frame.size.width, 50)];
    aNewTX2.hidden = YES;
    aNewTX2.keyboardType = UIKeyboardTypeNumberPad;
    [aNewTX2 addTarget:self action:@selector(txchangeB:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:aNewTX2];
    
    //进入界面，topTX成为第一响应
    [topTX becomeFirstResponder];

    for (int i = 0; i < 6; i++)
    {
        UITextField *pwdLabel = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -300)/2+i*50, 100, 50, 50)];
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
        UITextField *pwdLabel = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -300)/2+i*50, 180, 50, 50)];
        pwdLabel.layer.borderColor = [UIColor blackColor].CGColor;
        pwdLabel.enabled = NO;
        pwdLabel.textAlignment = NSTextAlignmentCenter;//居中
        pwdLabel.secureTextEntry = YES;//设置密码模式
        pwdLabel.layer.borderWidth = 1;
        [self.view addSubview:pwdLabel];
        
        [dataSource1 addObject:pwdLabel];
    }

    for (int i = 0; i < 6; i++)
    {
        UITextField *pwdLabel = [[UITextField alloc] initWithFrame:CGRectMake((SCREEN_WIDTH -300)/2+i*50, 260, 50, 50)];
        pwdLabel.layer.borderColor = [UIColor blackColor].CGColor;
        pwdLabel.enabled = NO;
        pwdLabel.textAlignment = NSTextAlignmentCenter;//居中
        pwdLabel.secureTextEntry = YES;//设置密码模式
        pwdLabel.layer.borderWidth = 1;
        [self.view addSubview:pwdLabel];
        [dataSource2 addObject:pwdLabel];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, SCREEN_WIDTH - 100, 30)];
    lab.text = @"请输入原密码";
    [self.view addSubview:lab];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH - 100, 30)];
    lab1.text = @"请输入新密码";
    [self.view addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, SCREEN_WIDTH - 100, 30)];
    lab2.text = @"请再次输入新密码";
    [self.view addSubview:lab2];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(10, 100, SCREEN_WIDTH, 50);
    [btn1 addTarget:self action:@selector(huo:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag = 1;
    [self.view addSubview:btn1];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(10, 180, SCREEN_WIDTH, 50);
    [btn3 addTarget:self action:@selector(huo:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag = 2;
    [self.view addSubview:btn3];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(10, 260, SCREEN_WIDTH, 50);
    [btn2 addTarget:self action:@selector(huo:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 3;
    [self.view addSubview:btn2];
    
    
    
    
    
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
        case 3:
        {
            [aNewTX2 becomeFirstResponder];

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
        NSLog(@"第二个");
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
        NSLog(@"第三个");
        pows2 = password;
        [aNewTX2 becomeFirstResponder];

    }
}
- (void)txchangeB:(UITextField *)tx
{
    [aNewTX2 becomeFirstResponder];

    NSString *password = tx.text;
    
    if (password.length == dataSource2.count)
    {
        [tx resignFirstResponder];//隐藏键盘
    }
    
    for (int i = 0; i < dataSource2.count; i++)
    {
        UITextField *pwdtx = [dataSource2 objectAtIndex:i];
        if (i < password.length)
        {
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdtx.text = pwd;
        }
        
    }
    
    if (password.length == 6)
    {
        NSLog(@"第四个个");
        pows3 = password;


    }
}
-(void)sumitBtn
{
    
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    //    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    NSDictionary *successDic = [notify userInfo][key];
    
}

- (void)failure:(NSNotification *)notify
{
    //    [self dismissIndicatorView];
    //    [self showAlertWithPoint:0
    //                        text:[notify userInfo][FAILURE]
    //                       color:UIPINK];
    
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
