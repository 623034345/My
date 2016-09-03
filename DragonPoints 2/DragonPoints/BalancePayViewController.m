//
//  BalancePayViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/9.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "BalancePayViewController.h"

@interface BalancePayViewController ()

@end

@implementation BalancePayViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIWHITE;
    dataSource = [[NSMutableArray alloc] initWithCapacity:10];
    
    [self setUI];
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    self.navigationItem.title = @"请输入支付密码";
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUI
{
    topTX = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    topTX.hidden = YES;
    topTX.keyboardType = UIKeyboardTypeNumberPad;
    [topTX addTarget:self action:@selector(txchange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:topTX];
    
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
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"输入的密码是" message:password delegate:nil cancelButtonTitle:@"完成" otherButtonTitles:nil, nil];
//        [alert show];
        //兑换商品支付
        if (self.number == 1)
        {
            [[HttpHelper sharedInstance] buyOfflineWithproductId:_productId
                                                       buyAmount:_buyAmount
                                                    leavemessage:_leavemessage
                                                  transactionPwd:password];
        }
        //余额支付
        if (self.number == 2)
        {
            //预售余额支付
            if (self.onType == 1)
            {
                [[HttpHelper sharedInstance] buyOfflinePayInBalanceHandlesaleId:self.saleId
                                                                 transactionPwd:password];
            }
            //立即买单余额支付
            if (self.onType == 2)
            {
                [[HttpHelper sharedInstance] buyOfflinePayInBalanceHandlesaleId:self.saleId
                                                                 transactionPwd:password];
            }
            //店铺详情买单余额支付
            if (self.onType == 3)
            {
                [[HttpHelper sharedInstance] BuyNowUseBalanceWithmoneyPay:self.priceNum
                                                                      psw:password];
            }
            

        }
        
    }
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    //兑换商品支付

    if ([PAYCOIN isEqualToString:key] )
    {
        NSDictionary *successDic = [notify userInfo][PAYCOIN];
        NSString *code = successDic[@"code"];
        if ([code integerValue] > 0)
        {
            NSLog(@"%@",successDic);
            [self showAlertWithPoint:0 text:@"支付成功" color:UICYAN];
            PaySuccessViewController *pvc = [[PaySuccessViewController alloc] init];
            pvc.addition = successDic[@"addition"];
            pvc.saleId = successDic[@"code"];
            [self.navigationController pushViewController:pvc animated:YES];

        }
        if ([code integerValue] == -1)
        {
            [self showAlertWithPoint:0 text:successDic[@"msg"] color:UIPINK];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        if ([code integerValue] == -2)
        {
            [self showAlertWithPoint:0 text:successDic[@"msg"] color:UIPINK];
            [self.navigationController popViewControllerAnimated:YES];

        }
        if ([code integerValue] == -3)
        {
            [self showAlertWithPoint:0 text:successDic[@"msg"] color:UIPINK];
            [self.navigationController popViewControllerAnimated:YES];

        }

    }
    //店铺买单余额支付
    if ([key isEqualToString:BUYNOWUSE]) {
        NSDictionary *successDic = [notify userInfo][BUYNOWUSE];
//        NSLog(@"%@",successDic);
        if ([successDic[@"code"] isEqualToString:@"1"]) {
            [self showAlertWithPoint:0
                                text:@"支付成功"
                               color:UICYAN];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UINavigationController *navVC = self.navigationController;
                NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
                for (UIViewController *vc in [navVC viewControllers]) {
                    [viewControllers addObject:vc];
                    if ([vc isKindOfClass:[DetailedViewController class]])
                    {
                        break;
                    }
                }
                [navVC setViewControllers:viewControllers animated:YES];
            });
        }
        if ([successDic[@"code"] isEqualToString:@"-1"]) {
            [self showAlertWithPoint:0
                                text:@"余额不足"
                               color:UIPINK];
        }
        if ([successDic[@"code"] isEqualToString:@"-2"]) {
            [self showAlertWithPoint:0
                                text:@"数据库错误"
                               color:UIPINK];
        }
        
    }
    //商品买单余额支付
    if ([key isEqualToString:BUYINUSE]) {
        NSDictionary *successDic = [notify userInfo][BUYINUSE];
//        NSLog(@"%@",successDic);
        if ([successDic[@"code"] isEqualToString:@"1"]) {
            [self showAlertWithPoint:0
                                text:@"支付成功"
                               color:UICYAN];
            if (self.onType == 1)
            {
                PaySuccessViewController *pvc = [[PaySuccessViewController alloc] init];
                pvc.data = successDic[@"po"];
                [self.navigationController pushViewController:pvc animated:YES];
            }
            else
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    UINavigationController *navVC = self.navigationController;
                    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
                    for (UIViewController *vc in [navVC viewControllers]) {
                        [viewControllers addObject:vc];
                        if ([vc isKindOfClass:[OfflineViewController class]])
                        {
                            break;
                        }
                    }
                    [navVC setViewControllers:viewControllers animated:YES];
                });


            }
        }
        if ([successDic[@"code"] isEqualToString:@"-1"]) {
            [self showAlertWithPoint:0
                                text:@"余额不足"
                               color:UIPINK];
        }
        if ([successDic[@"code"] isEqualToString:@"-2"]) {
            [self showAlertWithPoint:0
                                text:@"数据库错误"
                               color:UIPINK];
        }
        
    }
    
}
- (void)failure:(NSNotification *)notify
{
    [self showAlertWithPoint:0
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];}
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
