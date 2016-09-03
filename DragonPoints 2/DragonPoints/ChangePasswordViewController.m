//
//  ChangePasswordViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/10.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
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
    self.navigationItem.title = @"修改登录密码";
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
        if ([CHANGEP isEqualToString:key])
        {
            NSDictionary *successDic = [notify userInfo][CHANGEP];
//            NSLog(@"%@",successDic);
            NSString *code = successDic[@"code"];
            NSString *msg = successDic[@"msg"];
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
    
}

- (void)failure:(NSNotification *)notify
{
        [self dismissView];
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

- (IBAction)save:(id)sender {
    if (NULL_STR(_oldpows.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                    text:@"老密码不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    if (NULL_STR(_aNewPows1.text) && !NULL_STR(_oldpows.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                    text:@"新密码不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    if (NULL_STR(_aNewPows2.text) && !NULL_STR(_aNewPows1.text) && !NULL_STR(_oldpows.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                    text:@"新密码不能为空"
                                                                   color:UIRED];
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    if ([_aNewPows1.text isEqualToString:_aNewPows2.text]) {
        [[HttpHelper sharedInstance] changeThePasswordWithOldPwd:_oldpows.text
                                                         lnewPwd:_aNewPows1.text];
    }
    else
    {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                    text:@"两次新密码输入不一致"
                                                                   color:UIRED];
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    
    
}

@end
