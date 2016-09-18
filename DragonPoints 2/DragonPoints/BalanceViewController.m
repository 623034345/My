//
//  BalanceViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "BalanceViewController.h"

@interface BalanceViewController ()

@end

@implementation BalanceViewController

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
    self.navigationItem.title = @"我的余额";
    dataArr = [NSMutableArray array];
    dataDic = [NSDictionary dictionary];
    seletedIndex = 1;
    [self getData];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.delegate = self;
    table.dataSource = self;
    [table addHeaderWithTarget:self action:@selector(addHeader)];
    [table addFooterWithTarget:self action:@selector(addFooter)];
    [self showIndicatorView];
    [self.view addSubview:table];
    [self touchTable:table commentTableViewTouchInSide:@selector(commentTableViewTouchInSide)];
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
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
-(void)getData
{
    [[HttpHelper sharedInstance] MyBalanceInSystemWithtype:[NSString stringWithFormat:@"%ld",seletedIndex]];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
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
            }
            
            cell.textLabel.text = [NSString stringWithFormat:@"余额            %@",dataDic[@"balanceInSystem"]];
            return cell;
        }
        if (indexPath.row == 1)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellZY"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellZY"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
                
                textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 3, SCREEN_WIDTH - 90, 44)];
                textField.placeholder = @"请输入充值金额0.01-99999";
                [cell addSubview:textField];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(SCREEN_WIDTH - 80, 3, 70, 44);
                [btn setTitle:@"点击充值" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
                [btn setTitleColor:UIRED forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(zyeBtn) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:btn];
            }
            
            return cell;
        }
        if (indexPath.row == 2)
        {
            NSArray *labArr = @[@"全部",@"云豆转入",@"在线充值",@"消费支付",@"退款"];
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellfour"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellfour"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
                for (int a = 0; a < 5; a++ )
                {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
                    btn.frame = CGRectMake(a *SCREEN_WIDTH / 5, 0, SCREEN_WIDTH / 5, 50);
                    [btn setTitle:labArr[a] forState:UIControlStateNormal];
                    btn.tag = a+1;
                    [btn addTarget:self action:@selector(oneBtn:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:btn];
                }
            }
            UIButton *btn = (UIButton *)[cell viewWithTag:1];
            UIButton *btn2 = (UIButton *)[cell viewWithTag:2];
            UIButton *btn3 = (UIButton *)[cell viewWithTag:3];
            UIButton *btn4 = (UIButton *)[cell viewWithTag:4];
            UIButton *btn5 = (UIButton *)[cell viewWithTag:5];
            
            if (seletedIndex == 1) {
                [btn setTitleColor:UIRED forState:UIControlStateNormal];
                [btn2 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn3 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
                
                
            }if (seletedIndex == 2) {
                [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn2 setTitleColor:UIRED forState:UIControlStateNormal];
                [btn3 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
                
            }
            if (seletedIndex == 3)
            {
                [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn2 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn3 setTitleColor:UIRED forState:UIControlStateNormal];
                [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
            }
            if (seletedIndex == 4) {
                [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn2 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn3 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn4 setTitleColor:UIRED forState:UIControlStateNormal];
                [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
            }
            if (seletedIndex == 5) {
                [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn2 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn3 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn5 setTitleColor:UIRED forState:UIControlStateNormal];
            }
            return cell;
        }
        
    }
    if (indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSection"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellSection"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 79, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:lineView];
            for (int a = 0; a < 3; a++ )
            {
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(a *SCREEN_WIDTH / 3, 0, SCREEN_WIDTH / 3, 80)];
                lab.textAlignment = NSTextAlignmentCenter;
                lab.tag = a +10 ;
                [cell addSubview:lab];
            }
        }
        UILabel *lab = (UILabel *)[cell viewWithTag:10];
        UILabel *lab1 = (UILabel *)[cell viewWithTag:11];
        UILabel *lab2 = (UILabel *)[cell viewWithTag:12];
        lab.font = [UIFont systemFontOfSize:13.0f];
        lab.numberOfLines = 0;
        lab2.numberOfLines = 0;
        lab2.font = [UIFont systemFontOfSize:13.0f];
        MyBalanceModel *mod = dataArr[indexPath.row];
        lab.text = [NSString stringWithFormat:@"%@  %@",mod.changeId,mod.changeTime];
        lab1.text = mod.balanceChange;
        lab2.text = mod.theComment;
        
        
        
        return cell;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 80;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}
-(void)oneBtn:(UIButton *)btn
{
    if (btn.tag == 1)
    {
        seletedIndex = 1;
    }
    if (btn.tag == 2)
    {
        seletedIndex = 2;
        
    }
    if (btn.tag == 3)
    {
        seletedIndex = 3;
        
    }
    if (btn.tag == 4)
    {
        seletedIndex = 4;
        
    }
    if (btn.tag == 5)
    {
        seletedIndex = 5;
        
    }
    [table reloadData];
    
}
//提现金
-(void)txjBtn
{
    
}
//转余额
-(void)zyeBtn
{
    
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];
    [dataArr removeAllObjects];
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([key isEqualToString:SYSTEM])
    {
        dataDic = [notify userInfo][key];
        NSArray *balanceListArr = dataDic[@"balanceList"];
        [balanceListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MyBalanceModel *mod = [[MyBalanceModel alloc] init];
            [mod setValuesForKeysWithDictionary:obj];
            [dataArr addObject:mod];
        }];
        [table reloadData];

    }
    
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
-(void)commentTableViewTouchInSide
{
    [textField resignFirstResponder];
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
