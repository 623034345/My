//
//  TransactionViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "TransactionViewController.h"

@interface TransactionViewController ()

@end

@implementation TransactionViewController
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
    if (self.selectIndex)
    {
        carouselD.currentItemIndex = self.selectIndex;
    }
    else
    {
    }
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"订单";
    status = 1;
    dataArr  = [NSMutableArray array];
    [self createCarousel];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    [self getData];

}
-(void)getData
{
    [[HttpHelper sharedInstance] GetOrderListWithType:[NSString stringWithFormat:@"%d",status]];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createCarousel
{
    title = @[@"预售订单", @"店付订单", @"完成订单"];
    carouselD = [[iCarousel alloc]init];
    carouselD.backgroundColor = UICLEAR;
    carouselD.dataSource = self;
    carouselD.delegate = self;
    //页面滑动时的减速效果
    carouselD.decelerationRate = 0.7;
    //页面切换时的动画效果
    carouselD.type = iCarouselTypeLinear;
    //实现分页
    carouselD.pagingEnabled = YES;
    //边缘标识,即页面处在两边时,向已经没有页面的方向滑动的操作无法进行
    carouselD.edgeRecognition = YES;
    //此属性不设置时,向左滑动会跨页面,设为0时,无法滑动,
    carouselD.bounceDistance = 0.5;
    [self.view addSubview:carouselD];
    __weak typeof (carouselD)weakCarousel = carouselD;
    //设置导航标题与页面的关联属性
    CGRect frame = CGRectMake(0, 64, SCREEN_WIDTH, 45);
    segmentControl = [[XTSegmentControl alloc]initWithFrame:frame Items:title selectedBlock:^(NSInteger index)
                      {
                          [weakCarousel scrollToItemAtIndex:index animated:NO];
                      }];
    segmentControl.backgroundColor = UIWHITE;
    //有无下划线
    segmentControl.hadLine = YES;
    [self.view addSubview:segmentControl];
    
    
    carouselD.frame = CGRectMake(0, CGRectGetMaxY(segmentControl.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(segmentControl.frame));
    carouselD.frame = CGRectMake(0, CGRectGetMaxY(segmentControl.frame), SCREEN_WIDTH, SCREEN_HEIGHT-CGRectGetMaxY(segmentControl.frame));
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (status == 1) {
//     
//    }
//    SuccessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuccessTableViewCell"];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"SuccessTableViewCell" owner:self options:nil] lastObject];
//        cell.selectionStyle = UITableViewCellAccessoryNone;
//
//    }
//    cell.img.image = [UIImage imageNamed:@"shiyan"];
//    
//    return cell;
    static NSString *cellId1 = @"TransactTableViewCell";
    
    TransactTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TransactTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    ShopOrderModel *mod = dataArr[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:mod.productImage]];
    if ([mod.ifpayed isEqualToString:@"1"]) {
        cell.stateLab.text = @"未支付";

    }
    if ([mod.ifpayed isEqualToString:@"2"]) {
        cell.stateLab.text = @"已支付";
        
    }
    if ([mod.ifpayed isEqualToString:@"3"]) {
        cell.stateLab.text = @"已验证";
        
    }
    if ([mod.ifpayed isEqualToString:@"4"]) {
        cell.stateLab.text = @"已完成";
        
    }
    cell.shopName.text = mod.productName;
    if ([mod.isExchange isEqualToString:@"Y"]) {
        cell.price.text = [NSString stringWithFormat:@"￥%@",mod.productPrice];

    }
    if ([mod.isSpecial isEqualToString:@"Y"]) {
        cell.price.text = [NSString stringWithFormat:@"%@龙点币",mod.coinnum];
        
    }
    
    cell.btn.tag = indexPath.row;
    [cell.btn addTarget:self action:@selector(ydqr:) forControlEvents:UIControlEventTouchUpInside];

    switch (status) {
        case 1:
        {
            [cell.btn1 addTarget:self action:@selector(qxdd:) forControlEvents:UIControlEventTouchUpInside];

            cell.btn1.tag = indexPath.row;
        }
            break;
        case 2:
        {
            [cell.btn setTitle:@"确认" forState:UIControlStateNormal];
            [cell.btn1 setHidden:YES];


        }
            break;
        case 3:
        {
            [cell.btn setTitle:@"已完成" forState:UIControlStateNormal];
            [cell.btn setTitleColor:UIBLACK forState:UIControlStateNormal];
        
            [cell.btn1 setHidden:YES];
            [cell.btn setBackgroundImage:[UIImage imageNamed:@"52"] forState:UIControlStateNormal];
            
        }
            break;
            
        default:
            break;
    }
    
    return cell;
   
}
-(void)ydqr:(UIButton *)button
{
    ShopOrderModel *mod = dataArr[button.tag];
    //兑换
    if ([mod.isExchange isEqualToString:@"Y"])
    {
        [[HttpHelper sharedInstance] ScanRedeemCodeWithSaleId:mod.saleId];
    }
    //特价
    if ([mod.isSpecial isEqualToString:@"Y"])
    {
        [[HttpHelper sharedInstance] AfterConsumeWithSaleId:mod.saleId];
    }

    switch (status) {
        case 1:
        {
            NSLog(@"预售订单确认%ld",button.tag);

        }
            break;
        case 2:
        {
            NSLog(@"店付订单确认%ld",button.tag);

        }
            break;
            
        default:
            break;
    }
}
-(void)qxdd:(UIButton *)button
{
    NSLog(@"预售取消订单%ld",button.tag);
    ShopOrderModel *mod = dataArr[button.tag];
    [[HttpHelper sharedInstance] CancelOneOrderWithSaleId:mod.saleId];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (status == 1) {
        return 200;

    }
    return 200;
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
#pragma mark -iCarousel协议
//协议里的函数,整个页面分为3个部分
-(NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return title.count;
}
//协议里的函数，加载页面
-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    MyAppointmentView *myAppointmentView = [[MyAppointmentView alloc] initWithFrame:carousel.frame];
    myAppointmentView.appointTableView.dataSource = self;
    myAppointmentView.appointTableView.delegate = self;
    //添加上拉加载，下拉刷新
    [myAppointmentView.appointTableView addHeaderWithTarget:self
                                                     action:@selector(addHeader)];
    [myAppointmentView.appointTableView addFooterWithTarget:self
                                                     action:@selector(addFooter)];
    if (index == 0)
    {
        currentMyAppointmentView = myAppointmentView;
    }
    
    return myAppointmentView;
}
- (void)carouselDidScroll:(iCarousel *)carousel
{
    if (segmentControl)
    {
        float offset = carousel.scrollOffset;
        if (offset > 0)
        {
            [segmentControl moveIndexWithProgress:offset];
        }
    }
}
//让导航栏标题跟着页面的翻动而滑动
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    if (segmentControl)
    {
        
        [segmentControl endMoveIndex:carousel.currentItemIndex];
    }
}
- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    currentMyAppointmentView = (MyAppointmentView *)carousel.currentItemView;
    switch (carousel.currentItemIndex)
    {
        case 0:
        {
            status = 1;
        }
            break;
        case 1:
        {
            status = 2;
        }
            break;
        case 2:
        {
            status = 3;
        }
            break;
    }
    
    [self getData];
    [currentMyAppointmentView.appointTableView reloadData];
    
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
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [currentMyAppointmentView.appointTableView headerEndRefreshing];
    [currentMyAppointmentView.appointTableView footerEndRefreshing];
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([key isEqualToString:SHOPORDERLIST]) {
        NSDictionary *successDic = [notify userInfo][SHOPORDERLIST];
        NSLog(@"%@",successDic);
        NSArray *orderList = successDic[@"orderList"];
        [orderList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ShopOrderModel *mod = [[ShopOrderModel alloc] init];
            [mod setValuesForKeysWithDictionary:obj];
            [dataArr addObject:mod];
        }];
        [currentMyAppointmentView.appointTableView reloadData];
    }
    if ([key isEqualToString:CANCELORDER]) {
        NSDictionary *successDic = [notify userInfo][CANCELORDER];
        if ([successDic[@"code"] isEqualToString:@"1"]) {
            [self showAlertWithPoint:0 text:@"取消成功" color:UICYAN];
            [currentMyAppointmentView.appointTableView reloadData];

        }
        if ([successDic[@"code"] isEqualToString:@"-1"]) {
            [self showAlertWithPoint:0 text:@"取消失败" color:UIPINK];
            
        }
        

    }
    if ([key isEqualToString:AFTERCONSUME]) {
        NSDictionary *successDic = [notify userInfo][AFTERCONSUME];
        if ([successDic[@"code"] isEqualToString:@"1"]) {
            [self showAlertWithPoint:0 text:@"确认成功" color:UICYAN];
            [currentMyAppointmentView.appointTableView reloadData];
            
        }
        if ([successDic[@"code"] isEqualToString:@"-1"]) {
            [self showAlertWithPoint:0 text:@"确认失败" color:UIPINK];
            
        }
        
        
    }
    if ([key isEqualToString:AFTERCONSUME1]) {
        NSDictionary *successDic = [notify userInfo][AFTERCONSUME1];
        if ([successDic[@"code"] isEqualToString:@"1"]) {
            [self showAlertWithPoint:0 text:@"确认成功" color:UICYAN];
            [currentMyAppointmentView.appointTableView reloadData];
            
        }
        if ([successDic[@"code"] isEqualToString:@"-1"]) {
            [self showAlertWithPoint:0 text:@"确认失败" color:UIPINK];
            
        }
        
        
    }
    if (dataArr.count == 0) {
        [self showAlertWithPoint:0 text:@"您当前没有订单" color:UICYAN];
    }

    
}

- (void)failure:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [currentMyAppointmentView.appointTableView headerEndRefreshing];
    [currentMyAppointmentView.appointTableView footerEndRefreshing];
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
