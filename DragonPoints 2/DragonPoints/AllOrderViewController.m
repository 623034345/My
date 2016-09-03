//
//  AllOrderViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/3.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "AllOrderViewController.h"

@interface AllOrderViewController ()

@end

@implementation AllOrderViewController
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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIGRAY;
    switch (_status) {
        case 1:
            self.navigationItem.title = @"待付款";
            break;
        case 2:
            self.navigationItem.title = @"待收货";
            break;
        case 3:
            self.navigationItem.title = @"待评价";
            break;
        case 4:
            self.navigationItem.title = @"待付款";
            break;
        case 5:
            self.navigationItem.title = @"待使用";
            break;
        case 6:
            self.navigationItem.title = @"待评价";
            break;
        case 7:
            self.navigationItem.title = @"";
            break;
        case 8:
            self.navigationItem.title = @"";
            break;
            
        default:
            break;
    }
    table =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator =NO;
    [table addHeaderWithTarget:self action:@selector(addHeader)];
    [table addFooterWithTarget:self action:@selector(addFooter)];
    [self showIndicatorView];
    [self.view addSubview:table];

    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];

}
-(void)getData
{
    
}
//下拉刷新
-(void)addHeader
{
    [self getData];
    [self showIndicatorView];
}
//上拉加载
-(void)addFooter
{
    [self getData];
    
    [self showIndicatorView];
}
-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId1 = @"OrderTableViewCell";
    //    static NSString *cellId2 = @"AppointmentSeniorInfoTableViewCell";
    //    static NSString *cellId3 = @"MyAppointmentBtnTableViewCell";
    OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        [cell.saoBtn setHidden:YES];
    }
    [cell.btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn1.tag = indexPath.section;
    [cell.btn2 addTarget:self action:@selector(btn2:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn2.tag = indexPath.section;

    [cell.shopBtn addTarget:self action:@selector(shopBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.shopBtn.tag = indexPath.section;

    switch (_status) {
        case 1:
        {
            cell.jie.text = @"我一直都在流浪";
            [cell.btn1 setTitle:@"取消订单" forState:UIControlStateNormal];
            [cell.btn2 setTitle:@"付款" forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:UIWHITE forState:UIControlStateNormal];
            [cell.btn2 setBackgroundColor:UIRED];


            
        }
            break;
        case 2:
        {
            cell.jie.text = @"可我不曾见过海洋";
            [cell.btn1 setTitle:@"延迟收货" forState:UIControlStateNormal];
            [cell.btn2 setTitle:@"确认收货" forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:UIWHITE forState:UIControlStateNormal];
            [cell.btn2 setBackgroundColor:UIRED];
            
        }
            break;
        case 3:
        {
            cell.jie.text = @"夜空中最亮的星";
//            [cell.btn1 setTitle:@"提醒发货" forState:UIControlStateNormal];
            [cell.btn2 setTitle:@"评价" forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:UIWHITE forState:UIControlStateNormal];
            [cell.btn2 setBackgroundColor:UIRED];
        }
            break;
        case 4:
        {
            cell.jie.text = @"让我们荡起双桨";
            [cell.btn1 setTitle:@"取消订单" forState:UIControlStateNormal];
            [cell.btn2 setTitle:@"付款" forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:UIWHITE forState:UIControlStateNormal];
            [cell.btn2 setBackgroundColor:UIRED];
        }
            break;
        case 5:
        {
            cell.jie.text = @"小船儿推开波浪";
            [cell.btn1 setTitle:@"退款" forState:UIControlStateNormal];
            [cell.btn2 setTitle:@"订单券码" forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:UIWHITE forState:UIControlStateNormal];
            [cell.btn2 setBackgroundColor:UIRED];
        }
            break;
            
        case 6:
        {
            cell.jie.text = @"小船儿推开波浪";
            [cell.btn2 setTitle:@"去评价" forState:UIControlStateNormal];
            [cell.btn2 setTitleColor:UIWHITE forState:UIControlStateNormal];
            [cell.btn2 setBackgroundColor:UIRED];
        }
            break;
        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //线上商品详情
    if (_status > 0 && _status < 4) {
        EstoreViewController *dvc = [[EstoreViewController alloc] init];
        [self.navigationController pushViewController:dvc animated:YES];
    }
    //线下商品详情
    else
    {
        OfflineViewController *ovc = [[OfflineViewController alloc] init];
        ovc.productId = @"35";
        [self.navigationController pushViewController:ovc animated:YES];
    }
}
//店铺详情
-(void)shopBtn:(UIButton *)btn
{
    //线上店铺详情
    if (_status > 0 && _status < 4) {
        EstoreViewController *dvc = [[EstoreViewController alloc] init];
        [self.navigationController pushViewController:dvc animated:YES];
    }
    //线下店铺详情
    else
    {
        DetailedViewController *ovc = [[DetailedViewController alloc] init];
        [self.navigationController pushViewController:ovc animated:YES];
    }
}
-(void)btn1:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"退款"]) {
        RefundViewController *rvc = [[RefundViewController alloc] init];
        [self.navigationController pushViewController:rvc animated:YES];
    }
}
-(void)btn2:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:@"去评价"])
    {
        JudgeViewController *jvc = [[JudgeViewController alloc] init];
        [self.navigationController pushViewController:jvc animated:YES];
    }
    if ([button.titleLabel.text isEqualToString:@"订单券码"])
    {
        OrderInfoViewController *ovc = [[OrderInfoViewController alloc] init];
        [self.navigationController pushViewController:ovc animated:YES];
    }
}
- (void)btnClick:(UIButton *)btn
{
    selectedIndexPath = [currentMyAppointmentView.appointTableView indexPathForCell:(UITableViewCell *)[[[btn superview] superview] superview]];
    selectedDic = dataSource[selectedIndexPath.section];
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];
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
    
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];
    [self showAlertWithPoint:0
                        text:[notify userInfo][FAILURE]
                        color:UIPINK];
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
