//
//  CloudBeanViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "CloudBeanViewController.h"

@interface CloudBeanViewController ()

@end

@implementation CloudBeanViewController
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
    [self getData];

    
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
    self.navigationItem.title = @"我的龙豆";
//    data = [NSDictionary dictionary];
    dataArr = [NSMutableArray array];
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

-(void)getData
{
    [[HttpHelper sharedInstance] myBeanWithtype:[NSString stringWithFormat:@"%ld",(long)seletedIndex]];
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
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
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
            if (NULL_STR(data[@"beanBalance"])) {
                cell.textLabel.text = [NSString stringWithFormat:@"龙豆余额          0"];

            }
            else
            {
                cell.textLabel.text = [NSString stringWithFormat:@"龙豆余额          %@",data[@"beanBalance"]];

            }
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
                textField.placeholder = @"请输入余额 最少100";
                [cell addSubview:textField];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(SCREEN_WIDTH - 80, 3, 70, 44);
                [btn setTitle:@"转余额" forState:UIControlStateNormal];
                [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(zyeBtn) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:btn];
            }
            
            return cell;
        }
        if (indexPath.row == 2)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellZY"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellZY"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
                
                textField1 = [[UITextField alloc] initWithFrame:CGRectMake(5, 3, SCREEN_WIDTH - 90, 44)];
                textField1.placeholder = @"请输入提现金额 最少100";
                [cell addSubview:textField1];
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(SCREEN_WIDTH - 80, 3, 70, 44);
                [btn setTitle:@"提现金" forState:UIControlStateNormal];
                [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(txjBtn) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:btn];
            }
            
            return cell;
        }

        
        if (indexPath.row == 3)
        {
            NSArray *labArr = @[@"今日增收",@"本月增收",@"累计增收"];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTwo"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTwo"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
                for (int a = 0; a < 3; a++ )
                {
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(a *SCREEN_WIDTH / 3, 0, SCREEN_WIDTH / 3, 50)];
                    lab.textAlignment = NSTextAlignmentCenter;
                    lab.text = labArr[a];
                    [cell addSubview:lab];
                }
            }
            
            return cell;
        }
        if (indexPath.row == 4)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellthrid"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellthrid"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
                for (int a = 0; a < 3; a++ )
                {
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(a *SCREEN_WIDTH / 3, 0, SCREEN_WIDTH / 3, 50)];
                    lab.textAlignment = NSTextAlignmentCenter;
                    lab.tag = 109+a;
                    [cell addSubview:lab];
                }
            }
            if (data.count >0) {
                NSArray *labArr = @[data[@"todayGetBean"],data[@"thisMonthGetBean"],data[@"sumGetBean"]];
                
                for (int a = 0; a < 3; a ++)
                {
                    UILabel *lab = (UILabel *)[cell viewWithTag:a+109];
                    lab.text = [NSString stringWithFormat:@"%@",labArr[a]];
                }
            }
           
            return cell;
        }
        if (indexPath.row == 5)
        {
            NSArray *labArr = @[@"全部",@"推荐会员",@"推荐供应商",@"推荐机构",@"推荐商家"];
            
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
        MyBeanModel *mod = dataArr[indexPath.row];
        lab.text = [NSString stringWithFormat:@"%@ %@",mod.saleId,mod.saleTime];
        lab1.text = mod.beanChange;
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
    if ([textField1.text floatValue] > 99.99) {
        //已绑定银行卡
        if ([data[@"hasBankCard"] isEqualToString:@"Y"])
        {
            WithdrawViewController *wvc = [[WithdrawViewController alloc] init];
            wvc.moneyStr = textField1.text;
            wvc.hasBankCard = data[@"hasBankCard"];
            wvc.hasZhifubao = data[@"hasZhifubao"];
            [self.navigationController pushViewController:wvc animated:YES];
        }
        //已绑定支付宝
        if ([data[@"hasZhifubao"] isEqualToString:@"Y"])
        {
            WithdrawViewController *wvc = [[WithdrawViewController alloc] init];
            wvc.moneyStr = textField1.text;
            wvc.hasBankCard = data[@"hasBankCard"];
            wvc.hasZhifubao = data[@"hasZhifubao"];
            [self.navigationController pushViewController:wvc animated:YES];
        }
        if ([data[@"hasZhifubao"] isEqualToString:@"N"]&&[data[@"hasBankCard"] isEqualToString:@"N"])
        {
            ModifyViewController *mvc = [[ModifyViewController alloc] init];
            mvc.ghing = 2;
            [self.navigationController pushViewController:mvc animated:YES];
        }
    }
    else
    {
        [self showAlertWithPoint:0 text:@"提现不能少于100" color:UIPINK];
    }

}
//转余额
-(void)zyeBtn
{
    if ([textField.text floatValue] > 0.99)
    {
        [[HttpHelper sharedInstance] beanWithNum:textField.text];
    }
    else
    {
        [self showAlertWithPoint:0 text:@"转余额不能少于100" color:UIPINK];
    }
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];

    NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([key isEqualToString:BEAND]) {
        data = [NSDictionary dictionary];
        [dataArr removeAllObjects];
        data = [notify userInfo][key];

//        NSLog(@"%@",data);
        NSArray *arr = data[@"beanByOrderList"];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MyBeanModel *mod = [[MyBeanModel alloc] init];
            [mod setValuesForKeysWithDictionary:obj];
            [dataArr addObject:mod];
        }];
        [table reloadData];
        
    }
    if ([key isEqualToString:BALANCE]) {
        NSDictionary *successDic = [notify userInfo][key];
//        NSLog(@"%@",successDic);
        [self showAlertWithPoint:0 text:successDic[@"msg"] color:UICYAN];
        seletedIndex = 1;
        [self getData];
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
    [textField1 resignFirstResponder];

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
