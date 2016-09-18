//
//  MineViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
//    [self hideNavigationBarLine];
    [self.tabBarController.tabBar setHidden:NO];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    self.navigationItem.title = @"我的";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIWHITE;
    mineTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49) style:UITableViewStylePlain];
    mineTable.backgroundColor = UICLEAR;
    mineTable.delegate = self;
    mineTable.dataSource = self;
    mineTable.backgroundColor = UICOLOR_HEX(0xf9f9f9);
    [self.view addSubview:mineTable];
    [self headViewCreat];
    [self getData];
    
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
    if (NULL_STR([USER_DEFAULT objectForKey:USERID]))
    {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:lvc animated:NO];
    }
    else
    {
        dataDic = [NSDictionary dictionary];
        self.navigationItem.title = @"我的";
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.view.backgroundColor = UIWHITE;
        mineTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49) style:UITableViewStylePlain];
        mineTable.backgroundColor = UICLEAR;
        mineTable.delegate = self;
        mineTable.dataSource = self;
        mineTable.backgroundColor = UICOLOR_HEX(0xf9f9f9);
        [self.view addSubview:mineTable];
        [self headViewCreat];
        [self getData];
    }
    
  
}
-(void)getData
{
    [[HttpHelper sharedInstance] MyMainInfo];
}
-(void)headViewCreat
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64+SCREEN_WIDTH / 3)];
    view.backgroundColor = UICOLOR_HEX(0x2d3e52);
    mineTable.tableHeaderView = view;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 50, 40, 100, 100)];
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = 50;
    [img sd_setImageWithURL:[NSURL URLWithString:dataDic[@"memberHeadImageUrl"]] placeholderImage:[UIImage imageNamed:@"shiyan"]];
    [view addSubview:img];
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - 50, 40, 100, 100);
    [nextBtn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:nextBtn];
    
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(SCREEN_WIDTH / 2 - 50, 150, 100, 50);

    if (SCREEN_WIDTH < 440) {
        lab.frame = CGRectMake(SCREEN_WIDTH / 2 - 50, 145, 100, 50);

    }
    if (NULL_STR(dataDic[@"nickName"])) {
        lab.text = [USER_DEFAULT objectForKey:PHONE];

    }
    else
    {
        lab.text = dataDic[@"nickName"];

    }
    lab.font = [UIFont systemFontOfSize:15.0];
    lab.textColor = UIWHITE;
    lab.numberOfLines = 2;
    lab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lab];
    
//    UILabel *lab1 = [[UILabel alloc] init];
//    if (SCREEN_WIDTH < 440)
//    {
//        lab1.frame =  CGRectMake(SCREEN_WIDTH / 2 + 50, 130, 50, 50);
//    }
//    else
//    {
//        lab1.frame = CGRectMake(SCREEN_WIDTH / 2 + 50, 140, 50, 50);
//
//    }
//    lab1.text = @"Lv12";
//    lab1.textColor = [UIColor yellowColor];
//    lab1.textAlignment = NSTextAlignmentCenter;
//    [view addSubview:lab1];
    
    UIButton *vipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    vipBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - 80, 150, 40, 40);
    if (SCREEN_WIDTH < 440) {
        vipBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - 80, 150, 40, 40);

    }
    [vipBtn setImage:[UIImage imageNamed:@"zs"] forState:UIControlStateNormal];
    [view addSubview:vipBtn];
    
    UIButton *xiaoxiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    xiaoxiBtn.frame = CGRectMake(SCREEN_WIDTH - 70, 30, 30, 30);
    [xiaoxiBtn setBackgroundImage:[UIImage imageNamed:@"bxx"] forState:UIControlStateNormal];
    [xiaoxiBtn addTarget:self action:@selector(xiaoXi) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:xiaoxiBtn];


    
}
//消息
-(void)xiaoXi
{
//    PaySuccessViewController *pvc = [[PaySuccessViewController alloc] init];
//    [self.navigationController pushViewController:pvc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 1 || section == 2) {
//        return 2;
//    }
    if (section == 1) {
        return 2;
    }
    return 0.00000000000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 50;
        }
        if (indexPath.row == 1) {
            return 70;
        }
        if (indexPath.row == 2) {
            return 50;
        }
    }
//    if (indexPath.section == 1) {
//        return 80;
//    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 50;
        }
        return 80;
    }
    return SCREEN_WIDTH / 4 * 1.5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellOneL"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOneL"];
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
                img.image = [UIImage imageNamed:@"money"];
                [cell addSubview:img];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 80, 40)];
                lab.text = @"钱包/积分";
                [cell addSubview:lab];
                UIButton *qian = [UIButton buttonWithType:UIButtonTypeCustom];
                qian.frame = CGRectMake(SCREEN_WIDTH - 140, 5, 150, 40);
                [qian setTitle:@"查看全部 >" forState:UIControlStateNormal];
                [qian setTitleColor:UIBLACK forState:UIControlStateNormal];
                [qian addTarget:self action:@selector(jifenBtn) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:qian];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

            }
            return cell;
        }
        if (indexPath.row == 1) {
            //行间距
            
            int rowLength = 0;
            
            //列间距
            int columnLength = 0;
            NSArray *imgArr = [NSArray array];
            if (dataDic.count >0) {
                imgArr =@[dataDic[@"coinBalance"],dataDic[@"beansBalance"],dataDic[@"balanceInSystem"]];

            }
            NSArray *labArr =@[@"龙点币",@"龙豆",@"余额"];
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellTneL"];
            if (!cell || dataDic.count >0) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTneL"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = UICOLOR_HEX(0xf9f9f9);

                for (int n = 0; n < 3; n ++) {
                    int x = (n %4)*((SCREEN_WIDTH - 3)/3 + columnLength) + columnLength;
                    
                    int y = (n/4)*((SCREEN_WIDTH - 3)/3 - 30 + rowLength) + rowLength;
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 5)/3 - 1, 70);
                    [button setBackgroundColor:UICOLOR_HEX(0xf9f9f9)];
                    [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:button];
                    
                    UILabel *lab1 = [[UILabel alloc] init];
                    if (SCREEN_WIDTH >320) {
                        lab1.frame = CGRectMake(button.frame.origin.x - 4, 31, button.frame.size.width, 30);
                    }
                    else
                    {
                        lab1.frame = CGRectMake(button.frame.origin.x - 4, 40, button.frame.size.width, 20);
                    }
                    if (imgArr.count > 0) {
                        lab1.text = [NSString stringWithFormat:@"%@",[imgArr objectAtIndex:n]];

                    }
                    lab1.font = [UIFont systemFontOfSize:16];
                    lab1.textColor = UICOLOR_HEX(0xea4b35);
                    lab1.textAlignment = NSTextAlignmentCenter;
                    [cell addSubview:lab1];
                    UILabel *lab = [[UILabel alloc] init];
                    if (SCREEN_WIDTH >320) {
                        lab.frame = CGRectMake(button.frame.origin.x - 4, 5, button.frame.size.width, 30);
                    }
                    else
                    {
                        lab.frame = CGRectMake(button.frame.origin.x - 4, 10, button.frame.size.width, 10);
                    }
                    lab.text = [NSString stringWithFormat:@"%@",[labArr objectAtIndex:n]];
                    lab.font = [UIFont systemFontOfSize:14];
                    lab.textColor = UIBLACK;
                    lab.textAlignment = NSTextAlignmentCenter;
                    [cell addSubview:lab];
                 
                    
                }
                
            }
            return cell;
        }
        
//        if (indexPath.row == 2) {
//            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellOYeL"];
//            if (!cell) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOYeL"];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
//                img.image = [UIImage imageNamed:@"dd"];
//                [cell addSubview:img];
//                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 80, 40)];
//                lab.text = @"商城订单";
//                [cell addSubview:lab];
////                UIButton *qian = [UIButton buttonWithType:UIButtonTypeCustom];
////                qian.frame = CGRectMake(SCREEN_WIDTH - 140, 5, 150, 40);
////                [qian setTitle:@"查看全部 >" forState:UIControlStateNormal];
////                [qian setTitleColor:UIBLACK forState:UIControlStateNormal];
////                [qian addTarget:self action:@selector(dingDan) forControlEvents:UIControlEventTouchUpInside];
////                [cell addSubview:qian];
//                
//            }
//            return cell;
//            
//        }
    }
//    if (indexPath.section == 1) {
//        //行间距
//        
//        int rowLength = 1;
//        
//        //列间距
//        int columnLength = 1;
//        NSArray *imgArr =@[@"fukuan",@"shuo",@"pingjia"];
//        NSArray *labArr =@[@"代付款",@"待收货",@"待评价"];
////        NSArray *numArr =@[@"1",@"3",@"2",@"4"];
//
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThirdT"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellThirdT"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.backgroundColor = UICOLOR_HEX(0xf9f9f9);
//
//            for (int n = 0; n < 3; n ++) {
//                int x = (n %3)*((SCREEN_WIDTH - 3)/3 + columnLength) + columnLength;
//                
//                int y = (n/3)*((SCREEN_WIDTH - 3)/3 - 30 + rowLength) + rowLength;
//                //                    NSLog(@"X:%d y:%d",x,y);
//                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
//                button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 3)/3 - 1, 80);
//                [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:n]] forState:UIControlStateNormal];
//                button.tag = n;
//                [button addTarget:self action:@selector(datailBtn:) forControlEvents:UIControlEventTouchUpInside];
//                [cell addSubview:button];
//                UILabel *lab = [[UILabel alloc] init];
//                if (SCREEN_WIDTH >320) {
//                    lab.frame = CGRectMake(button.frame.origin.x, button.frame.size.height - 20, button.frame.size.width, 20);
//                }
//                else
//                {
//                    lab.frame = CGRectMake(button.frame.origin.x, button.frame.size.height - 15, button.frame.size.width, 10);
//                }
//                lab.text = [NSString stringWithFormat:@"%@",[labArr objectAtIndex:n]];
//                lab.font = [UIFont systemFontOfSize:14];
//                lab.textColor = UIBLACK;
//                lab.textAlignment = NSTextAlignmentCenter;
//                [cell addSubview:lab];
//                
//            }
//            
//
//        }
//        
//        return cell;
//    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellOYeL"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOYeL"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 30, 30)];
                img.image = [UIImage imageNamed:@"dd"];
                [cell addSubview:img];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 80, 40)];
                lab.text = @"商家订单";
                [cell addSubview:lab];
            }
            return cell;
            
        }
        
        if (indexPath.row == 1) {
            //行间距
            
            int rowLength = 1;
            
            //列间距
            int columnLength = 1;
            NSArray *imgArr =@[@"dfk",@"dsy",@"pingjia"];
            NSArray *labArr =@[@"代付款",@"待使用",@"待评价"];
            //        NSArray *numArr =@[@"1",@"3",@"2",@"4"];
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThirdT"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellThirdT"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = UICOLOR_HEX(0xf9f9f9);
                
                for (int n = 0; n < 3; n ++) {
                    int x = (n %3)*((SCREEN_WIDTH - 3)/3 + columnLength) + columnLength;
                    
                    int y = (n/3)*((SCREEN_WIDTH - 3)/3 - 30 + rowLength) + rowLength;
                    //                    NSLog(@"X:%d y:%d",x,y);
                    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 3)/3 - 1, 80);
                    [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:n]] forState:UIControlStateNormal];
                    button.tag = n;
                    [button addTarget:self action:@selector(datailBtn1:) forControlEvents:UIControlEventTouchUpInside];
                    [cell addSubview:button];
                    UILabel *lab = [[UILabel alloc] init];
                    if (SCREEN_WIDTH >320) {
                        lab.frame = CGRectMake(button.frame.origin.x, button.frame.size.height - 20, button.frame.size.width, 20);
                    }
                    else
                    {
                        lab.frame = CGRectMake(button.frame.origin.x, button.frame.size.height - 15, button.frame.size.width, 10);
                    }
                    lab.text = [NSString stringWithFormat:@"%@",[labArr objectAtIndex:n]];
                    lab.font = [UIFont systemFontOfSize:14];
                    lab.textColor = UIBLACK;
                    lab.textAlignment = NSTextAlignmentCenter;
                    [cell addSubview:lab];
                    
                }
                
                
            }
            
            return cell;
        }
    }

    if (indexPath.section == 2)
    {
        //行间距
        
        int rowLength = 5;
        
        //列间距
        int columnLength = 1;
        NSArray *imgArr =@[@"sc",@"sj",@"fx",@"yl"];//@"qd",@"chuangke",@"lt",@"zj",@"chou",@"fh",@"yl"
        NSArray *labArr =@[@"收藏",@"商家入口",@"分享",@"运营中心"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFour"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFour"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            for (int n = 0; n < 4; n ++) {
                int x = (n %4)*((SCREEN_WIDTH - 4)/4 + columnLength) + columnLength;
                int y = (n/4)*((SCREEN_WIDTH - 4)/4 - 30 + rowLength) + rowLength;
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 4)/4 - 1, (SCREEN_WIDTH - 4)/4 - 4);
                [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:n]] forState:UIControlStateNormal];
                button.tag = n;
//                [button setBackgroundImage:[imgArr objectAtIndex:n] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(navBtn:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:button];
                UILabel *lab = [[UILabel alloc] init];
                if (n > 3 || n < 8) {
                    if (SCREEN_WIDTH < 440) {
                        lab.frame =  CGRectMake(button.frame.origin.x, button.frame.size.height*2 - 30, button.frame.size.width, 20);

                         lab.frame =  CGRectMake(button.frame.origin.x, button.frame.size.height*2 - 37, button.frame.size.width, 20);
                    }
                }
                if (n < 4) {
             
                    lab.frame =  CGRectMake(button.frame.origin.x, button.frame.size.height - 18, button.frame.size.width, 20);
                    

                }
                if (n > 7) {
                    if (SCREEN_WIDTH < 440) {
                        lab.frame =  CGRectMake(button.frame.origin.x, button.frame.size.height*3 - 20, button.frame.size.width, 20);
                    }

                    lab.frame =  CGRectMake(button.frame.origin.x, button.frame.size.height*3 - 60, button.frame.size.width, 20);

                }
      
                lab.text = [NSString stringWithFormat:@"%@",[labArr objectAtIndex:n]];
                lab.font = [UIFont systemFontOfSize:14];
//                lab.textColor = UICOLOR_HEX(0xa71520);
                lab.textAlignment = NSTextAlignmentCenter;
                [cell addSubview:lab];
                
            }

        }
        
        return cell;
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 2;
    }

    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
//待处理订单
-(void)datailBtn1:(UIButton *)button
{
    AllOrderViewController *avc = [[AllOrderViewController alloc] init];
    avc.status = button.tag +4;
    //    avc.selectIndex = button.tag;
    [self.navigationController pushViewController:avc animated:YES];
}
//待处理订单
-(void)datailBtn:(UIButton *)button
{
    AllOrderViewController *avc = [[AllOrderViewController alloc] init];
    avc.status = button.tag +1;
//    avc.selectIndex = button.tag;
    [self.navigationController pushViewController:avc animated:YES];
}
//下面商家入口
-(void)navBtn:(UIButton *)button
{
    if (button.tag == 0) {
        CollectViewController *cvc = [[CollectViewController alloc] init];
        [self.navigationController pushViewController:cvc animated:YES];
    }
    if (button.tag == 1) {
        SettledLoginViewController  *svc = [[SettledLoginViewController alloc] init];
        [self.navigationController pushViewController:svc animated:YES];
//        if ([dataDic[@"ifHasShopper"] isEqualToString:@"Y"]) {
//            MyShopViewController *mvc = [[MyShopViewController alloc] init];
//            [self.navigationController pushViewController:mvc animated:YES];
//        }
//        else
//        {
//            SettledShopViewController *svc = [[SettledShopViewController alloc] init];
//            [self.navigationController pushViewController:svc animated:YES];
//        }
    }
    if (button.tag == 5) {
        FootMarkViewController *fvc = [[FootMarkViewController alloc] init];
        [self.navigationController pushViewController:fvc animated:YES];
    }
    if (button.tag == 2) {
        [self shared];
    }
    if (button.tag == 3) {
        OperationsCenterViewController *ovc = [[OperationsCenterViewController alloc] init];
        [self.navigationController pushViewController:ovc animated:YES];
    }
}
//钱包积分下面四个按钮
-(void)go:(UIButton *)button
{
    EstateViewController *evc = [[EstateViewController alloc] init];
    [self.navigationController pushViewController:evc animated:YES];
}
//钱包积分全部分类
-(void)jifenBtn
{
    EstateViewController *evc = [[EstateViewController alloc] init];
    [self.navigationController pushViewController:evc animated:YES];
//    JudgeViewController *jvc = [[JudgeViewController alloc] init];
//    [self.navigationController pushViewController:jvc animated:YES];
}
//查看全部订单
-(void)dingDan
{
//    AllOrderViewController *avc = [[AllOrderViewController alloc] init];
//    [self.navigationController pushViewController:avc animated:YES];
}
#pragma mark - 网络监听
- (void)success:(NSNotification *)notify
{
    [mineTable.tableHeaderView removeFromSuperview];
    NSString *key = [[[notify userInfo] allKeys] lastObject];
    dataDic = [notify userInfo][key];
//    NSLog(@"%@",dataDic);
    [self headViewCreat];
    [mineTable reloadData];
    
}

- (void)failure:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [self showAlertWithPoint:0
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];
    
}
-(void)shared
{
    AllShareViewController *avc = [[AllShareViewController alloc] init];
    [self.navigationController pushViewController:avc animated:YES];
}
//个人中心
-(void)nextBtn
{
    MineSettingViewController *mvc = [[MineSettingViewController alloc] init];
    [self.navigationController pushViewController:mvc animated:YES];
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
