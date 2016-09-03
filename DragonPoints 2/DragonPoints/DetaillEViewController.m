//
//  DetaillEViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/4.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "DetaillEViewController.h"

@interface DetaillEViewController ()

@end

@implementation DetaillEViewController
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
    // Do any additional setup after loading the view.969fa8
    seleted = 0;
    self.view.backgroundColor = UICOLOR_HEX(0x969fa8);
    self.navigationItem.title = @"商品列表";
    // Do any additional setup after loading the view.
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
    [self creatTopBtn];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}
-(void)creatTopBtn
{
    NSArray *arr = @[@"星级",@"销量",@"价格",];
    for (int i = 0; i < 3; i ++) {
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i *(SCREEN_WIDTH/3), 64, SCREEN_WIDTH / 3 -1, 40);
        [btn setBackgroundColor:UICOLOR_HEX(0xf9f9f9)];
        if (i == seleted)
        {
            [btn setTitleColor:UIRED forState:UIControlStateNormal];
            
        }
        else
        {
            [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
        }
        btn.tag = i;
        [btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(shang:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    EdetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EdetailTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EdetailTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellAccessoryNone;

    }
    [cell.star displayRating:3.5];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 130;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopDatailViewController *svc = [[ShopDatailViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
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
    
}
-(void)shang:(UIButton *)btn
{
    seleted = btn.tag;
    [self creatTopBtn];

    
  
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
