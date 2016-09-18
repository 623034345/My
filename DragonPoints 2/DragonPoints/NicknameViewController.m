//
//  NicknameViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/11.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "NicknameViewController.h"

@interface NicknameViewController ()

@end

@implementation NicknameViewController
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
    self.navigationItem.title = @"修改昵称";
    
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
    NSDictionary *successDic = [notify userInfo][key];
    NSLog(@"%@",successDic);
    if ([successDic[@"code"] isEqualToString:@"1"]) {
        [self showAlertWithPoint:1 text:@"修改成功" color:UICYAN];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];

        });
    }
    else
    {
        [self showAlertWithPoint:1 text:@"修改失败" color:UIPINK];

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


- (IBAction)saveBtn:(id)sender
{
    [[HttpHelper sharedInstance] UpdateNickNameWithNickName:_nameTX.text];
}
@end
