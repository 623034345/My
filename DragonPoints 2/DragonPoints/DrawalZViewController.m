//
//  DrawalZViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/25.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "DrawalZViewController.h"

@interface DrawalZViewController ()

@end

@implementation DrawalZViewController

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
    self.navigationItem.title = @"提现信息确认";
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self creatView];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn setBackgroundColor:UIRED];
    [btn addTarget:self action:@selector(btnQ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
//确认
-(void)btnQ
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = UICOLOR_HEX(0x969fa8);
        [cell addSubview:lineView];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, 50)];
        lab.tag = 94;
        [cell addSubview:lab];
        
    }
    UILabel *lab = (UILabel *)[cell viewWithTag:94];
    switch (indexPath.row) {
        case 0:
        {
            lab.text = [NSString stringWithFormat:@"提现金额      190"];
            
        }
            break;
        case 1:
        {
            lab.text = [NSString stringWithFormat:@"转入账户      支付宝"];
            
        }
            break;
        case 2:
        {
            lab.text = [NSString stringWithFormat:@"支付宝账号     622346541567564545123"];
            
        }
            break;
        case 3:
        {
            lab.text = [NSString stringWithFormat:@"账户类型        个人"];
            
        }
            break;
        case 4:
        {
            lab.text = [NSString stringWithFormat:@"账户主人     齐天大圣"];
            
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    //    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    NSDictionary *successDic = [notify userInfo][key];
    [self showAlertWithPoint:1 text:@"您的提现申请已提交,我们会在3个工作日内处理,请耐心等待!!!" color:UICYAN];
}

- (void)failure:(NSNotification *)notify
{
        [self dismissIndicatorView];
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
