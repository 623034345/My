//
//  AddProfileViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/10.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "AddProfileViewController.h"

@interface AddProfileViewController ()

@end

@implementation AddProfileViewController
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
    self.navigationItem.title = @"添加收货地址";
    isSelected = NO;
    self.view.backgroundColor = UIWHITE;
    [_btn.layer setBorderColor:UIRED.CGColor];
    [_btn.layer setBorderWidth:1];
    [_btn.layer setMasksToBounds:YES];
    
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
    //    if ([JUDGE isEqualToString:key])
    //    {
    //        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
    //                                                                    text:@"评论成功"
    //                                                                   color:UICYAN];
    //        [KEYWINDOW addSubview:infoAlert];
    //        [infoAlert showView];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            if (self.typeOne == 1)
    //            {
    //
    //            }
    //
    //            [self.navigationController popViewControllerAnimated:YES];
    //
    //        });
    //
    //
    //    }
    
}

- (void)failure:(NSNotification *)notify
{
    //    [self dismissView];
    //    [self showAlertWithPoint:0
    //                        text:[notify userInfo][FAILURE]
    //                       color:UIPINK];
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
//设为默认
- (IBAction)lBtn:(UIButton *)sender
{
    if (!isSelected) {
        isSelected = YES;
    }
    else
    {
        isSelected = NO;
    }
    if (isSelected) {
        [_btn setBackgroundColor:UIRED];
    }
    else
    {
        [_btn setBackgroundColor:UIWHITE];
    }
}
//保存
- (IBAction)save:(id)sender
{
    if (NULL_STR(_name.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                    text:@"名字不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    if (NULL_STR(_tell.text) && !NULL_STR(_name.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                    text:@"电话不能为空"
                                                                   color:UIRED];
        
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    if (NULL_STR(_locLab.text) && !NULL_STR(_name.text) && !NULL_STR(_tell.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                    text:@"详细地址不能为空"
                                                                   color:UIRED];
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }
    if ([_choosLoc.titleLabel.text isEqualToString:@"请选择地址"] && !NULL_STR(_name.text) && !NULL_STR(_tell.text) && !NULL_STR(_locLab.text)) {
        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                    text:@"详细地址不能为空"
                                                                   color:UIRED];
        [KEYWINDOW addSubview:infoAlert];
        [infoAlert showView];
    }

}
//选择地址
- (IBAction)choosL:(UIButton *)sender
{
    CityViewController *city = [[CityViewController alloc] init];
    //选择以后的回调
    [city returnCityInfo:^(NSString *province, NSString *city, NSString *area,NSString *town, NSInteger S, NSInteger Q, NSInteger X, NSInteger Z) {

        NSString *name = [NSString stringWithFormat:@"%@ %@ %@ %@",province,city,area,town];
        [_choosLoc setTitle:name forState:UIControlStateNormal];
        
    }];
    [self.navigationController pushViewController:city animated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
