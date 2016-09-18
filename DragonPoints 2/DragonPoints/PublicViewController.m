//
//  PublicViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "PublicViewController.h"

@interface PublicViewController ()

@end

@implementation PublicViewController
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
    self.navigationItem.title = @"公益互助基金";
    dataDic = [NSDictionary dictionary];
    dataArr = [NSMutableArray array];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self creatView];
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    [self getData];
}
-(void)getData
{
    [[HttpHelper sharedInstance] MutualFundInfo];

}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    view.backgroundColor = UICOLOR_HEX(0xea4b35);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 30)];
    lab.text = @"您的公益互助基金已累积";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor  = UIWHITE;
    [view addSubview:lab];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 50)];
    lab1.text = dataDic[@"MutualAndSupportOld"];
    lab1.textAlignment = NSTextAlignmentCenter;
    lab1.font = [UIFont systemFontOfSize:24];
    lab1.textColor  = UIWHITE;
    [view addSubview:lab1];
    
    table.tableHeaderView = view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;

    }
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 50)];
                lab.text = @"其中: ";
                [cell addSubview:lab];
            }
            
            return cell;
        }
        if (indexPath.row == 1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTwo"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTwo"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 150, 50)];
                lab.tag = 741;
                [cell addSubview:lab];
                UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
                btn1.frame = CGRectMake(SCREEN_WIDTH - 140, 0, 100, 50);
                [btn1 setTitle:@"申请帮助" forState:UIControlStateNormal];
                [btn1 setTitleColor:UIRED forState:UIControlStateNormal];
                [btn1 addTarget:self action:@selector(txjBtn) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:btn1];
            }
            UILabel *lab = (UILabel *)[cell viewWithTag:741];
            lab.text = [NSString stringWithFormat:@"互助基金     %@点",dataDic[@"Mutual"]];
            
            
            return cell;
        }
        if (indexPath.row == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThird"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellThird"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 50)];
                lab.tag = 963;
                [cell addSubview:lab];
            }
            UILabel *lab = (UILabel *)[cell viewWithTag:963];
            lab.text = [NSString stringWithFormat:@"养老基金     %@点",dataDic[@"SupportOld"]];
            
            
            return cell;
        }
        if (indexPath.row == 3) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThird"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellThird"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                
                
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
                lab.textAlignment = NSTextAlignmentCenter;
                lab.tag = 852;
                [cell addSubview:lab];
            }
            UILabel *lab = (UILabel *)[cell viewWithTag:852];
            lab.text = [NSString stringWithFormat:@"公益互助基金管理使用规则"];
            
            
            return cell;
        }
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFour"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFour"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH / 2, 50)];
            lab.tag = 456;
            lab.font = [UIFont systemFontOfSize:13.0f];
            lab.numberOfLines = 0;
            [cell addSubview:lab];
            UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 5, 0, SCREEN_WIDTH / 2, 50)];
            lab1.tag = 789;
            [cell addSubview:lab1];
        }
        UILabel *lab  =(UILabel *)[cell viewWithTag:456];
        UILabel *lab1  =(UILabel *)[cell viewWithTag:789];
        MutualModel *mod = dataArr[indexPath.row];
        lab.text = [NSString stringWithFormat:@"订单%@  %@",mod.saleId,mod.saleTime];
        lab1.text = mod.coinChange;

        
        return cell;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//申请帮助
-(void)txjBtn
{
    HelpViewController *hvc = [[HelpViewController alloc] init];
    [self.navigationController pushViewController:hvc animated:YES];
}

#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    [table.tableHeaderView removeFromSuperview];
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    dataDic = [notify userInfo][key];
    NSArray *successArr = dataDic[@"mutualByOrderList"];
//    NSLog(@"公益%@",dataDic);
    [successArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MutualModel *mod = [[MutualModel alloc] init];
        [mod setValuesForKeysWithDictionary:obj];
        [dataArr addObject:mod];
    }];
    [self creatView];
    [table reloadData];
    
}

- (void)failure:(NSNotification *)notify
{
        [self dismissIndicatorView];
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
