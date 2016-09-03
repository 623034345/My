//
//  SilkViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/15.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "SilkViewController.h"

@interface SilkViewController ()

@end

@implementation SilkViewController
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
    self.navigationItem.title = @"我的掌创江湖";
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 40;
        }
        if (indexPath.row == 1) {
            return 70;
        }
    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 2;
    }
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        DoraemonsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoraemonsTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DoraemonsTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }

        
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
                lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
                [cell addSubview:lineView];
            }
            cell.textLabel.text = @"今日新增";
            return cell;
        }
        else
        {
            DoraemonsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DoraemonsTableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DoraemonsTableViewCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellAccessoryNone;
            }
            [cell.btn1 setHidden:YES];
            [cell.btn2 setHidden:YES];
            [cell.btn3 setHidden:YES];
            cell.lab1.textColor = UIBLACK;
            cell.lab2.textColor = UIBLACK;
            cell.lab3.textColor = UIBLACK;
            cell.lab4.textColor = UIBLACK;
            cell.lab5.textColor = UIBLACK;
            cell.lab6.textColor = UIBLACK;

            
            return cell;
        }
        
    }
    else
    {
        NSArray *arr = @[@"总舵主 (市级分公司)",@"分舵主 (县区级运营中心)",@"坛主 (乡镇级服务中心)",@"掌盟 (联盟商家)",@"掌商 (供货商)"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTwo"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTwo"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -130, 0, 100, 40)];
            lab.tag = 25;
            [cell addSubview:lab];
        
        }
        cell.textLabel.text = arr[indexPath.section - 2];
        UILabel *lab = (UILabel *)[cell viewWithTag:25];
        lab.text = @"154";
        return cell;
    }
    
    return nil;
}
-(void)datailBtn:(UIButton *)button
{
    
}


-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    //    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    NSDictionary *successDic = [notify userInfo][key];
    InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:1
                                                                text:@"您的提现申请已提交,我们会在3个工作日内处理,请耐心等待!!!"
                                                               color:UICYAN];
    [KEYWINDOW addSubview:infoAlert];
    [infoAlert showView];
}

- (void)failure:(NSNotification *)notify
{
    //    [self dismissIndicatorView];
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

@end
