//
//  PaySuccessViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/9.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "PaySuccessViewController.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"支付成功";
    if (_data.count == 0) {
        _data = [NSDictionary dictionary];

    }
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    table.delegate =self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    if (_data.count == 0) {
        [self getData];
        
    }

    
}
-(void)getData
{
    [[HttpHelper sharedInstance] payCoinSuccessWithsaleId:self.saleId];
}
-(void)backBtn
{
//    PreSaleViewController *pvc = [[PreSaleViewController alloc] init];
//    [self.navigationController popToViewController:pvc animated:YES];
    UINavigationController *navVC = self.navigationController;
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (UIViewController *vc in [navVC viewControllers]) {
        [viewControllers addObject:vc];
        if ([vc isKindOfClass:[PreSaleViewController class]]) {
            break;
        }
    }
    [navVC setViewControllers:viewControllers animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_data.count>0) {
        return 4;

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, 40, 200, 30)];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.tag = 14;
            [cell addSubview:lab];
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, 80, 200, 30)];
            lab1.tag = 15;
            lab1.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lab1];
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, 120, 100, 100)];
            img.tag = 963;
            [cell addSubview:img];
            

            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 220, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
        }
        UILabel *lab  = (UILabel *)[cell viewWithTag:14];
        UILabel *lab1  = (UILabel *)[cell viewWithTag:15];
        UIImageView *img = (UIImageView *)[cell viewWithTag:963];
        img.image = [self QRcodeWithText:_data[@"redeemcode"] size:100.0];
        img.layer.shadowOffset=CGSizeMake(0, 0.5);//设置阴影的偏移量
        img.layer.shadowRadius=1;//设置阴影的半径
        img.layer.shadowColor=[UIColor blackColor].CGColor;//设置阴影的颜色为黑色
        img.layer.shadowOpacity=0.3;
        lab.text = @"您的商品兑换码是";
        lab1.text = _data[@"redeemcode"];
        return cell;

    }
    if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTow"];
        if (!cell ) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTow"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
            img.tag = 17;
            [cell addSubview:img];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 50)];
            lab.tag = 16;
            [cell addSubview:lab];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];

        }
        UILabel *lab  = (UILabel *)[cell viewWithTag:16];
        UIImageView *img = (UIImageView *)[cell viewWithTag:17];
        lab.text = _data[@"shopperName"];
        [img sd_setImageWithURL:[NSURL URLWithString:_data[@"shopperImage"]]];
        return cell;

    }
    if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellt"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellt"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 100, 100)];
            img.tag = 18;
            [cell addSubview:img];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, SCREEN_WIDTH - 130, 50)];
            lab.numberOfLines = 0;
            lab.tag = 19;
            [cell addSubview:lab];
            
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 55, 100, 40)];
            lab1.textColor = UIRED;
            lab1.tag = 20;
            [cell addSubview:lab1];
            
            UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 100, 55, 90, 40)];
            lab2.textAlignment = NSTextAlignmentRight;
            lab2.tag = 21;
            [cell addSubview:lab2];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 119, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
            
        }
        UIImageView *img = (UIImageView *)[cell viewWithTag:18];
        UILabel *lab  = (UILabel *)[cell viewWithTag:19];
        UILabel *lab1  = (UILabel *)[cell viewWithTag:20];
        UILabel *lab2  = (UILabel *)[cell viewWithTag:21];
        [img sd_setImageWithURL:[NSURL URLWithString:_data[@"productmainImage"]]];
        lab.text = _data[@"productname"];
        if (NULL_STR(self.saleId))
        {
            lab1.text = [NSString stringWithFormat:@"￥ %@",_data[@"productprice"]];

            
        }
        else
        {
            lab1.text = [NSString stringWithFormat:@"%@龙点币",_data[@"productprice"]];

        }
        lab2.text = [NSString stringWithFormat:@"*%@",_data[@"buyAmount"]];

        return cell;
    }
    if (indexPath.row == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellF"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellF"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 300, 20, 300, 50)];
            lab.tag = 22;
            lab.textColor = UIRED;
            [cell addSubview:lab];
        }
        UILabel *lab = (UILabel *)[cell viewWithTag:22];
        if (NULL_STR(self.saleId)) {
            lab.text = [NSString stringWithFormat:@"%@件商品,共%@元",_data[@"buyAmount"],_data[@"productprice"]];


        }
        else
        {
            lab.text = [NSString stringWithFormat:@"%@件商品,共%@龙点币",_data[@"buyAmount"],_data[@"productprice"]];

        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 221;
    }
    else if (indexPath.row == 1)
    {
        return 60;
    }
    else if (indexPath.row == 2)
    {
        return 120;
    }
    return SCREEN_HEIGHT - 300;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
//二维码
-(void)emm
{
    
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([PAYCOINSUCCESS isEqualToString:key] )
    {
        _data = [notify userInfo][PAYCOINSUCCESS];
        NSLog(@"%@",_data);

    }
    [table reloadData];
    
    
}
- (void)failure:(NSNotification *)notify
{
    [self showAlertWithPoint:1
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
