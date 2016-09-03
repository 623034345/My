//
//  GradeViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/15.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "GradeViewController.h"

@interface GradeViewController ()

@end

@implementation GradeViewController
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
    self.navigationItem.title = @"我的等级";
    dataArr = [NSMutableArray array];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    [self creatView];
    [self getData];

}
-(void)getData
{
    [[HttpHelper sharedInstance] MyShownGrade];
}
-(void)creatView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = UIWHITE;
    table.tableHeaderView = view;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    lab.text = @"我目前的等级";
    lab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lab];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    GradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GradeTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"GradeTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    [cell.img sd_setImageWithURL:[NSURL URLWithString:dataDic[@"memberHeadImageUrl"]]];
    switch (indexPath.section) {
        case 0:
        {
            [cell.upBtn setHidden:YES];
            [cell.cardBtn setTitle:dataArr[0] forState:UIControlStateNormal];
        }
            break;
        case 1:
        {
            [cell.upBtn addTarget:self action:@selector(upBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.upBtn.tag = 8;
            [cell.cardBtn setTitle:dataArr[1] forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            [cell.upBtn addTarget:self action:@selector(upBtn:) forControlEvents:UIControlEventTouchUpInside];
            cell.upBtn.tag = 9;
            [cell.cardBtn setTitle:dataArr[2] forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MembersAgreementViewController *mvc = [[MembersAgreementViewController alloc] init];
    switch (indexPath.section) {
        case 0:
        {
            mvc.typeOn = 1;
        }
            break;
        case 1:
        {
            mvc.typeOn = 2;

        }
            break;
        case 2:
        {
            mvc.typeOn = 3;

        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:mvc animated:YES];
}
-(void)upBtn:(UIButton *)button
{
    switch (button.tag) {
        case 8:
        {
            PayViewController *pvc = [[PayViewController alloc] init];
            pvc.cardName = @"金卡会员权益";
            pvc.numText = @"10";
            [self.navigationController pushViewController:pvc animated:YES];
        }
            break;
        case 9:
        {
            PayViewController *pvc = [[PayViewController alloc] init];
            pvc.cardName = @"钻卡会员权益";
            pvc.numText = @"20";

            [self.navigationController pushViewController:pvc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    dataDic = [NSDictionary dictionary];
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    dataDic = [notify userInfo][key];
//    NSLog(@"%@",dataDic);
    dataArr = dataDic[@"gradeList"];
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
