//
//  ProfileViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/10.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
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
    _selected = -1;
    self.navigationItem.title = @"收货地址";
    self.view.backgroundColor = UIWHITE;
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
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
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(SCREEN_WIDTH/2 - 100, 40, 50, 50);
            [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(addBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-40, 40, 140, 40)];
            lab.text = @"添加新的地址";
            [cell addSubview:lab];
        }
        return cell;
      
    }
    ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProfileTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    //遍历数组  如果发现当前索引和数组中的索引相同 表示该单元格刚才操作过，对应显示另外的图片
        if (indexPath.row == _selected)
        {
            [cell.lab setHidden:NO];
            [cell.btn setImage:[UIImage imageNamed:@"rsele"] forState:UIControlStateNormal];
            
        }
    else
    {
        [cell.lab setHidden:YES];
        [cell.btn setImage:[UIImage imageNamed:@"bse"] forState:UIControlStateNormal];
    }
    cell.name.text = @"张豪  1751054120054";
    cell.cont.text = @"地址:新疆维吾尔自治区乌鲁木齐市水磨沟区高温路锅炉一号351851部队";
    [cell.btn addTarget:self action:@selector(choos:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn.tag = indexPath.row;
    cell.btn.exclusiveTouch = YES;
    [cell.deletel addTarget:self action:@selector(deletel:) forControlEvents:UIControlEventTouchUpInside];
    cell.deletel.tag = indexPath.row+30;
    return cell;
}
//选择默认地址
-(void)choos:(UIButton *)button
{

    for (int i=0;i < 2;i++) {//num为总共设置单选效果按钮的数目
//        UIButton *btn = (UIButton*)[view viewWithTag:i];//view为这些btn的父视图
        if (button.tag == i) {
            button.selected = NO;
            _selected = i;
        }
        if ((button.selected = YES))
        {
            button.selected = YES;//sender.selected = !sender.selected;
        }
     
    }
 
    [table reloadData];
}
//删除地址
-(void)deletel:(UIButton *)button
{
    
}

//添加新的地址
-(void)addBtn
{
    AddProfileViewController *avc = [[AddProfileViewController alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
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
