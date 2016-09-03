//
//  EstateViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "EstateViewController.h"

@interface EstateViewController ()
{
    NSDictionary *dataDic;
}
@end

@implementation EstateViewController

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
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"财产";
    dataDic = [NSDictionary dictionary];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
    [self getData];
}
-(void)getData
{
    [[HttpHelper sharedInstance] MyAssets];
}
-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma tableData
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EstateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EstateTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EstateTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    NSArray *arr = @[@"myb",@"myd",@"mq",@"credit_cards",@"mjj",@"mfh",@"mdj",@"mfs",];
    cell.img.image = [UIImage imageNamed:arr[indexPath.section]];
    switch (indexPath.section) {
        case 0:
        {
            if (NULL_STR(dataDic[@"coinBalance"])) {
                cell.name.text = [NSString stringWithFormat:@"我的龙点币     0"];

            }
            else
            {
                cell.name.text = [NSString stringWithFormat:@"我的龙点币     %@",dataDic[@"coinBalance"]];

            }
        }
            break;
        case 1:
        {
            if (NULL_STR(dataDic[@"beansBalance"])) {
                cell.name.text = [NSString stringWithFormat:@"我的龙豆     0"];
                
            }
            else
            {
                cell.name.text = [NSString stringWithFormat:@"我的龙豆     %@",dataDic[@"beansBalance"]];
                
            }

        }
            break;
        case 2:
        {
            if (NULL_STR(dataDic[@"balanceInSystem"])) {
                cell.name.text = [NSString stringWithFormat:@"我的余额     0元"];
                
            }
            else
            {
                cell.name.text = [NSString stringWithFormat:@"我的余额     %@元",dataDic[@"balanceInSystem"]];
                
            }

        }
            break;
        case 3:
        {
            cell.name.text = [NSString stringWithFormat:@"提现账户管理"];

        }
            break;
        case 4:
        {
            if (NULL_STR(dataDic[@"mutualFund"])) {
                cell.name.text = [NSString stringWithFormat:@"公益互助基金    0元"];
                
            }
            else
            {
                cell.name.text = [NSString stringWithFormat:@"公益互助基金     %@元",dataDic[@"mutualFund"]];
                
            }

        }
            break;
        case 5:
        {
            if (NULL_STR(dataDic[@"spendingBonus"])) {
                cell.name.text = [NSString stringWithFormat:@"消费分红账户    0元"];
                
            }
            else
            {
                cell.name.text = [NSString stringWithFormat:@"消费分红账户     %@元",dataDic[@"spendingBonus"]];
                
            }

        }
            break;
        case 6:
        {
            cell.name.text = [NSString stringWithFormat:@"我的等级"];

        }
            break;
        case 7:
        {
            if (NULL_STR(dataDic[@"myRecommendTotal"])) {
                cell.name.text = [NSString stringWithFormat:@"我的粉丝    0人"];
                
            }
            else
            {
                cell.name.text = [NSString stringWithFormat:@"我的粉丝    %@人",dataDic[@"myRecommendTotal"]];
                
            }

        }
            break;
            
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
            //云币我的云币CloudMoney
        case 0:
        {
            CloudMoneyViewController *cvc = [[CloudMoneyViewController alloc] init];
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
            //我的云豆
        case 1:
        {
            CloudBeanViewController *cvc = [[CloudBeanViewController alloc] init];
            [self.navigationController pushViewController:cvc animated:YES];
            
        }
            break;
            //我的余额
        case 2:
        {
            BalanceViewController *bvc = [[BalanceViewController alloc] init];
            [self.navigationController pushViewController:bvc animated:YES];
            
        }
            break;
            //提现账户管理
        case 3:
        {
            //当绑定银行卡的时候
            if ([dataDic[@"hasBankCard"] isEqualToString:@"Y"])
            {
                AdministrationViewController *avc = [[AdministrationViewController alloc] init];
                avc.onType = 1;
                avc.hasZhifubao = dataDic[@"hasZhifubao"];
                avc.hasBankCard = dataDic[@"hasBankCard"];
                [self.navigationController pushViewController:avc animated:YES];
            }
            //当绑定支付宝的时候
            else if ([dataDic[@"hasZhifubao"] isEqualToString:@"Y"])
            {
                AdministrationViewController *avc = [[AdministrationViewController alloc] init];
                avc.onType = 2;
                avc.hasZhifubao = dataDic[@"hasZhifubao"];
                avc.hasBankCard = dataDic[@"hasBankCard"];
                [self.navigationController pushViewController:avc animated:YES];
            }
            //当为绑定账号的时候
            else
            {
                ModifyViewController *mvc = [[ModifyViewController alloc] init];
                mvc.ghing = 2;
                [self.navigationController pushViewController:mvc animated:YES];
            }
        }
            break;
            //公益互助基金
        case 4:
        {
            PublicViewController *pvc = [[PublicViewController alloc] init];
            [self.navigationController pushViewController:pvc animated:YES];
        }
            break;
            //消费分红账户
        case 5:
        {
            DividendViewController *dvc = [[DividendViewController alloc] init];
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
           // 我的等级
        case 6:
        {
            GradeViewController *gvc = [[GradeViewController alloc] init];
            [self.navigationController pushViewController:gvc animated:YES];
        }
            break;
            //我的粉丝
        case 7:
        {
            SilkViewController *svc = [[SilkViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
        NSString *key = [[[notify userInfo] allKeys] lastObject];
    if ([key isEqualToString:ASSETS]) {
        dataDic = [notify userInfo][key];
//        NSLog(@"%@",dataDic);

    }
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
