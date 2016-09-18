//
//  CashpaymentsViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/21.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "CashpaymentsViewController.h"

@interface CashpaymentsViewController ()

@end

@implementation CashpaymentsViewController
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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"现金支付";
    _lab1.text = [NSString stringWithFormat:@"订单号:7864123415453423123454231231"];
    _lab2.text = [NSString stringWithFormat:@"下单时间:2016/08/19 12:29"];
    _lab3.text = [NSString stringWithFormat:@"商品名称:浪漫七夕情侣套盒"];
    _lab4.text = [NSString stringWithFormat:@"商品类型:特价商品"];
    _lab5.text = [NSString stringWithFormat:@"商品价格:99.00"];
    _lab6.text = [NSString stringWithFormat:@"会员信息:18423456745145"];

}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([LOGIN isEqualToString:key] )
    {
        NSDictionary *successDic = [notify userInfo][LOGIN];
        NSDictionary *data = successDic[DATAS];
        
        NSArray *sourceArray = data[@"AdvertisementViewList"];
        
        [sourceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             //             FirstRcmdModel *mod =[[FirstRcmdModel alloc]init];
             //             [mod setValuesForKeysWithDictionary:obj];
             //             [scrollerArray addObject:mod];
         }];
    }
    
    
}
- (void)failure:(NSNotification *)notify
{
    
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
