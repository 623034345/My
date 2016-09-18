//
//  SpecificationViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/5.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "SpecificationViewController.h"

@interface SpecificationViewController ()

@end

@implementation SpecificationViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"选择商品规格";
    _btnMutableArray = [NSMutableArray array];
    _btnMutableArray1 = [NSMutableArray array];

    arr = @[@"规格1",@"规格2",@"规格3",@"规格4",@"规格5",@"规格6",@"规格7",@"规格8",@"规格9"];

    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 153) style:UITableViewStyleGrouped];
    table.backgroundColor = UIWHITE;
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self creatView];
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backBtn)];
}
-(void)backBtn
{
    [USER_DEFAULT setObject:@"" forKey:@"spe0"];
    [USER_DEFAULT setObject:@"" forKey:@"spe1"];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 89, SCREEN_WIDTH, 89)];
    view.backgroundColor = UIWHITE;
    [self.view addSubview:view];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 40, SCREEN_WIDTH, 49);
    [btn setBackgroundColor:UICOLOR_HEX(0xea4b35)];
    [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
    [btn setTitle:@"提交订单" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(subMitBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    choosLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    choosLab.textAlignment = NSTextAlignmentRight;
    [view addSubview:choosLab];
}
-(void)subMitBtn
{
//    [USER_DEFAULT objectForKey:@"spe0"]
//    [USER_DEFAULT objectForKey:@"spe1"]
    [USER_DEFAULT setObject:@"" forKey:@"spe0"];
    [USER_DEFAULT setObject:@"" forKey:@"spe1"];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"specCell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"specCell"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 40)];
            lab.tag = 21;
            [cell addSubview:lab];
        }
        UILabel *lab = (UILabel *)[cell viewWithTag:21];
        lab.text = @"规格名";
        //行间距
        int rowLength = 5;
        //列间距
        int columnLength = 30;
        
        for (int n = 0; n < arr.count; n ++)
        {
            int x = (n %4)*((SCREEN_WIDTH - 120)/4 + columnLength) + columnLength;
            int y = (n/4)*(40+ rowLength) + rowLength + 60;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = n;
            button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 120)/4, 40);
            [button addTarget:self action:@selector(goOne:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:UIBLACK forState:UIControlStateNormal];
            [button setTitle:[arr objectAtIndex:n] forState:UIControlStateNormal];
            [cell addSubview:button];
            [_btnMutableArray addObject:button];
            
        }
        
        
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"specCell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"specCell"];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 40)];
        lab.tag = 21;
        [cell addSubview:lab];
    }
    UILabel *lab = (UILabel *)[cell viewWithTag:21];
    lab.text = @"规格名";
    //行间距
    int rowLength = 5;
    //列间距
    int columnLength = 30;
    
    for (int n = 0; n < arr.count; n ++)
    {
        int x = (n %4)*((SCREEN_WIDTH - 120)/4 + columnLength) + columnLength;
        int y = (n/4)*(40+ rowLength) + rowLength + 60;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = n;
        button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 120)/4, 40);
        [button addTarget:self action:@selector(goTwo:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:UIBLACK forState:UIControlStateNormal];
        [button setTitle:[arr objectAtIndex:n] forState:UIControlStateNormal];
        [cell addSubview:button];
        [_btnMutableArray1 addObject:button];
        
    }
    
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60 + arr.count/4 *70;
}
-(void)goOne:(UIButton *)button
{
    for (UIButton *btn in _btnMutableArray){
        
        
        if (btn.tag == button.tag) {
            
            btn.backgroundColor =[UIColor redColor];
            [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
            [USER_DEFAULT setObject:btn.titleLabel.text
                             forKey:@"spe0"];
            NSString *name1 = [USER_DEFAULT objectForKey:@"spe0"];
            NSString *name2 = [USER_DEFAULT objectForKey:@"spe1"];
            
            if (NULL_STR(name1)) {
                name1 = @"";
            }
            if (NULL_STR(name2)) {
                name2 = @"";
                
            }
            choosLab.text = [NSString stringWithFormat:@"已选%@ %@",name1,name2];
   
            
            
        } else {
            
            btn.backgroundColor =[UIColor whiteColor];
            [btn setTitleColor:UIBLACK forState:UIControlStateNormal];

            
        }
        
    }
    
    
}
-(void)goTwo:(UIButton *)button
{
    for (UIButton *btn in _btnMutableArray1){
        
        
        if (btn.tag == button.tag) {
            
            btn.backgroundColor =[UIColor redColor];
            [btn setTitleColor:UIWHITE forState:UIControlStateNormal];
            [USER_DEFAULT setObject:btn.titleLabel.text
                             forKey:@"spe1"];
            NSString *name1 = [USER_DEFAULT objectForKey:@"spe0"];
            NSString *name2 = [USER_DEFAULT objectForKey:@"spe1"];

            if (NULL_STR(name1)) {
                name1 = @"";
            }
            if (NULL_STR(name2)) {
                name2 = @"";

            }
            choosLab.text = [NSString stringWithFormat:@"已选%@ %@",name1,name2];

            
        } else {
            
            btn.backgroundColor =[UIColor whiteColor];
            [btn setTitleColor:UIBLACK forState:UIControlStateNormal];

            
        }
        
    }
    

}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([LOGIN isEqualToString:key] )
    {
        NSDictionary *successDic = [notify userInfo][LOGIN];
        NSDictionary *data = successDic[DATAS];
        
        NSArray *sourceArray = data[@"AdvertisementViewList"];
        
        [sourceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             //             FirstRcmdModel *mod =[[FirstRcmdModel alloc]init];
             //             [mod setValuesForKeysWithDictionary:obj];
             //             [scrollerArray addObject:mod];
         }];
    }
    
    
}
- (void)failure:(NSNotification *)notify
{
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
