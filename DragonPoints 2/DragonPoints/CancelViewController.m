//
//  CancelViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "CancelViewController.h"

@interface CancelViewController ()

@end

@implementation CancelViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"订单验证";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    [self hideNavigationBarLine];
    [self.tabBarController.tabBar setHidden:YES];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIWHITE;
    dataArr = [NSMutableArray array];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64) style:UITableViewStyleGrouped];
    table.backgroundColor = UIWHITE;
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
    if (dataArr.count == 0) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataArr.count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 40, 20, 80, 80)];
            img.image = [UIImage imageNamed:@"yanz"];
            [cell addSubview:img];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 40, 100, 80, 20)];
            lab.text = @"验证失败";
            lab.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:lab];
        }
        return cell;
    }
    
    SuccessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuccessTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SuccessTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        
    }
    cell.img.image = [UIImage imageNamed:@"shiyan"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];

    
}

- (void)failure:(NSNotification *)notify
{
    [self dismissView];
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
