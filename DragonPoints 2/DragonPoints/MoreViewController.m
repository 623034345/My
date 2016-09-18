//
//  MoreViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;

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
    // Do any additional setup after loading the view from its nib.
    [[HttpHelper sharedInstance] moreGetdata];
    self.navigationItem.title = @"全部分类";

 
    moreArr = [NSMutableArray array];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(backUp)];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 66) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return moreArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];//以indexPath来唯一确定cell

//    MoreTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *button;
    
    //行间距
    
    int rowLength = 5;
    
    //列间距
    int columnLength = 2;
    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"MoreTableViewCell" owner:self options:nil] lastObject];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 30)];
        lab.tag = 101;
//        lab.text = moreArr[indexPath.row][@"start"];
        lab.textColor = UIRED;
        [cell addSubview:lab];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        img.tag = 202;
        [cell addSubview:img];
    }
    //        belArr = moreArr[indexPath.row][@"code"];
    UILabel *lab = (UILabel *)[cell viewWithTag:101];
    UIImageView *img = (UIImageView *)[cell viewWithTag:202];
    MoreOneModel *mod = moreArr[indexPath.row];
    lab.text = mod.largecname;
    [img sd_setImageWithURL:[NSURL URLWithString:mod.categoryImage]];
    for (int n = 0; n < mod.smallccategoryOfflineList.count; n ++) {
        MoreTwoModel *tmod = mod.smallccategoryOfflineList[n];
        int x = (n %4)*((SCREEN_WIDTH - 1)/4 + columnLength) + columnLength;
        int y = (n/4)* 32 + rowLength +50;
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 1)/4 - 1, 30);
        [button setBackgroundColor:UICOLOR_HEX(0xf9f9f9)];
        [button setTitle:tmod.cname forState:UIControlStateNormal];
        [button setTitleColor:UIBLACK forState:UIControlStateNormal];
        button.tag = n;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:button];
        
    }
    if(mod.smallccategoryOfflineList.count%4==0)
    {
        self.cellHeight = mod.smallccategoryOfflineList.count / 4 * 50 + 30;
    }
    if(mod.smallccategoryOfflineList.count%4==1)
    {
        self.cellHeight = mod.smallccategoryOfflineList.count / 4 * 50 + 50;
    }
    else
    {
        self.cellHeight = (mod.smallccategoryOfflineList.count) / 4 * 50 + 30 + 50;
        
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 2) {
        return 3 * 50 + 30;

    }
    return self.cellHeight;
 
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}
-(void)btnClick:(UIButton *)button
{
    HomeDetailViewController *hvc = [[HomeDetailViewController alloc] init];
    hvc.className = button.titleLabel.text;
    [self.navigationController pushViewController:hvc animated:YES];
//    NSLog(@"%@",button.titleLabel.text);
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([MORE isEqualToString:key] )
    {
        NSDictionary *successDic = [notify userInfo][MORE];
        
//        NSLog(@"数据 %@",successDic);

        NSArray *sourceArray1 = successDic[@"categoryOfflineList"];
        if (![sourceArray1 isKindOfClass:[NSNull class]]) {
            for (NSDictionary *wdic in sourceArray1)
            {
                MoreOneModel *mod = [[MoreOneModel alloc] init];
                [mod setValuesForKeysWithDictionary:wdic];
                NSArray *huodong  = wdic[@"smallccategoryOfflineList"];
                NSMutableArray *arr1 = [NSMutableArray array];
                [huodong enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    MoreTwoModel *floor = [[MoreTwoModel alloc] init];
                    [floor setValuesForKeysWithDictionary:obj];
                    [arr1 addObject:floor];
                }];
                mod.smallccategoryOfflineList = arr1;
                [moreArr addObject:mod];
            }
        }

    }
    
    [table reloadData];
    
}
- (void)failure:(NSNotification *)notify
{
    
}

-(void)backUp
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
