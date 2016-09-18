//
//  OperationsCenterViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/31.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "OperationsCenterViewController.h"

@interface OperationsCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
}
@end

@implementation OperationsCenterViewController
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
    self.navigationItem.title = @"运营中心";
    [self addBackBtnWithImageNormal:@"back" fuction:@selector(backBtn)];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewAutomaticDimension;
    [self.view addSubview:table];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return 10;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        OcenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OcenterTableViewCell"];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OcenterTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        
        }
        cell.lab1.text = @"某县运营中心";
        cell.lab2.text = @"已入驻商家:121";
        return cell;
    }
    if (indexPath.section == 1)
    {
        OperationsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OperationsTableViewCell"];
        if (!cell)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"OperationsTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            
        }
        [cell.btn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn.tag = indexPath.row;
        cell.lab1.text = @"这是一个个很长很长的店铺名字";
        cell.lab2.text = @"这是一个很长很长的类别";
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }
    return 90;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(void)show:(UIButton *)button
{
    AuditShopViewController *avc = [[AuditShopViewController alloc] init];
    
    [self.navigationController pushViewController:avc animated:YES];
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    //    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    NSDictionary *successDic = [notify userInfo][key];
    
}

- (void)failure:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [self showAlertWithPoint:0
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];
    
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
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
