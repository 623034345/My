//
//  AccountViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title = @"账本";
    //automaticallyAdjustsScrollViewInsets
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
    self.navigationItem.title = @"账本";
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *textArr = @[@"今天的访客量",@"今天处理订单",@"今天结算金额￥"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 59)];
        lab.tag = 1;
        lab.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lab];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = UIBLACK;
        [cell addSubview:lineView];
    }
    UILabel *lab = (UILabel *)[cell viewWithTag:1];
    lab.text = [NSString stringWithFormat:@"%@   99",[textArr objectAtIndex:indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    //    if ([JUDGE isEqualToString:key])
    //    {
    //        InfoAlert *infoAlert = [[InfoAlert alloc] initInfoAlertWithPoint:0
    //                                                                    text:@"评论成功"
    //                                                                   color:UICYAN];
    //        [KEYWINDOW addSubview:infoAlert];
    //        [infoAlert showView];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            if (self.typeOne == 1)
    //            {
    //
    //            }
    //
    //            [self.navigationController popViewControllerAnimated:YES];
    //
    //        });
    //
    //
    //    }
    
}

- (void)failure:(NSNotification *)notify
{
    //    [self dismissView];
    //    [self showAlertWithPoint:0
    //                        text:[notify userInfo][FAILURE]
    //                       color:UIPINK];
}
-(void)localMap
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
