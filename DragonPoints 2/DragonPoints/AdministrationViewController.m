//
//  AdministrationViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/13.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "AdministrationViewController.h"

@interface AdministrationViewController ()

@end

@implementation AdministrationViewController
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
    self.navigationItem.title = @"提现账户管理";
    dataDic = [NSDictionary dictionary];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    [self getData];
}
-(void)getData
{
    [[HttpHelper sharedInstance] BeanWithdrawWithwithdrawNum:@"100"
                                                 hasBankCard:self.hasBankCard
                                                 hasZhifubao:self.hasZhifubao];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;

    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
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
            [btn1 setTitle:@"修改" forState:UIControlStateNormal];
            [btn1 setTitleColor:UIRED forState:UIControlStateNormal];
            [btn1 addTarget:self action:@selector(txjBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn1];
        }
        UILabel *lab = (UILabel *)[cell viewWithTag:741];
        lab.text = [NSString stringWithFormat:@"账户信息"];
            
            
            return cell;
        }
    else
    {
   
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellT2o"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellT2o"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
//            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
//            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
//            [cell addSubview:lineView];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH , 44)];
            lab.tag = 741;
            lab.font = [UIFont systemFontOfSize:13.0f];
            [cell addSubview:lab];

        }
        UILabel *lab = (UILabel *)[cell viewWithTag:741];
        if (_onType == 1) {
            switch (indexPath.row)
            {
                            case 1:
                {
                    lab.text = [NSString stringWithFormat:@"开户行      %@",dataDic[@"bankName"]];
                    
                }
                    break;
                case 2:
                {
                    lab.text = [NSString stringWithFormat:@"银行卡号      %@",dataDic[@"bankCardId"]];
                    
                }
                    break;
                case 3:
                {
                    lab.text = [NSString stringWithFormat:@"开户行        %@",dataDic[@"bankOpen"]];
                    
                }
                    break;
                case 4:
                {
                    lab.text = [NSString stringWithFormat:@"持卡人姓名     %@",dataDic[@"bankOwnerName"]];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
        if (_onType == 2)
        {
            switch (indexPath.row)
            {
                case 1:
                {
                    lab.text = [NSString stringWithFormat:@"开户类型      支付宝"];
                    
                }
                    break;
                case 2:
                {
                    lab.text = [NSString stringWithFormat:@"支付宝账户      %@",dataDic[@"zhifubaoCode"]];
                    
                }
                    break;
                case 3:
                {
                    lab.text = [NSString stringWithFormat:@"支付宝类型        %@",dataDic[@"zhifubaoType"]];

                    
                }
                    break;
                case 4:
                {
                    lab.text = [NSString stringWithFormat:@"支付宝所有人     %@",dataDic[@"zhifubaoUsername"]];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
        return cell;
    }
    return nil;
}
//修改账户信息
-(void)txjBtn
{
    ModifyViewController *mvc = [[ModifyViewController alloc] init];
    mvc.ghing = 1;
    mvc.oneType = self.onType;
    [self.navigationController pushViewController:mvc animated:YES];
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([key isEqualToString:DRAWBEAN]) {
        dataDic = [notify userInfo][key];
//        NSLog(@"是什么啊%@",dataDic);
        [table reloadData];
        
    }
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
