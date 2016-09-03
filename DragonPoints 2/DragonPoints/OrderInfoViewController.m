//
//  OrderInfoViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/16.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "OrderInfoViewController.h"

@interface OrderInfoViewController ()

@end

@implementation OrderInfoViewController
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
    self.navigationItem.title = @"订单信息";
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 6;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, 20, 200, 30)];
            lab.tag = 14;
            lab.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lab];
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, 60, 200, 30)];
            lab1.textAlignment = NSTextAlignmentCenter;
            lab1.tag = 15;
            [cell addSubview:lab1];
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCREEN_WIDTH/2 - 40, 100, 80, 80);
            btn.tag = 75;
            [btn addTarget:self action:@selector(emm) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 179, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UIBLACK;
            [cell addSubview:lineView];
        }
        UILabel *lab  = (UILabel *)[cell viewWithTag:14];
        UILabel *lab1  = (UILabel *)[cell viewWithTag:15];
        UIButton *btn = (UIButton *)[cell viewWithTag:75];
        [btn setBackgroundImage:[UIImage imageNamed:@"emm"] forState:UIControlStateNormal];

        lab.text = @"您的商品兑换码是";
        lab1.text = @"ewqerefd12534751124";
        return cell;
        
    }
    if (indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellF"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellF"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, SCREEN_WIDTH - 40, 40)];
            lab.tag = 22;
            lab.textColor = UIBLACK;
            [cell addSubview:lab];
        }
        UILabel *lab = (UILabel *)[cell viewWithTag:22];
        switch (indexPath.row) {
            case 0:
            {
                lab.text = [NSString stringWithFormat:@"订单号   1567685412454541514"];
            }
                break;
            case 1:
            {
                lab.text = [NSString stringWithFormat:@"下单时间  2016-12-31 14:18"];
            }
                break;
            case 2:
            {
                lab.text = [NSString stringWithFormat:@"有效期    2017-12-31 23:59"];
            }
                break;
            case 3:
            {
                lab.text = [NSString stringWithFormat:@"总价      49.80元"];
            }
                break;
            case 4:
            {
                lab.text = [NSString stringWithFormat:@"数量      2"];
            }
                break;
            case 5:
            {
                lab.text = [NSString stringWithFormat:@"订单完成后,将获得云币赠送."];
            }
                break;
            default:
                break;
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 180;
    }
    else if (indexPath.section == 1)
    {
        return 50;
    }
    return 44;

}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
//二维码
-(void)emm
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
    InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                text:[notify userInfo][FAILURE]
                                                               color:UIPINK];
    [KEYWINDOW addSubview:infoAlert];
    [infoAlert showView];
    
    
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
