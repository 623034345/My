//
//  SearchViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/1.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ( view.tag == 44) {
            [view setHidden:NO];
        }
    }
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
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if (view.tag == 44) {
            [view setHidden:YES];
        }
    }
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    _hisArr = [NSMutableArray array];
    _isHasEqual = NO;
    [self creatPlist];
    //获取路径
    NSString * filename =[self getPlistPath];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filename];
    self.hisArr= [dic objectForKey:searchKey];
    self.view.backgroundColor = UIWHITE;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 30);
    [backBtn addTarget:self
                action:@selector(localMap)
      forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:backBtn];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backBtnItem;
    
    bar = [[UISearchBar alloc]initWithFrame:CGRectMake(70, 0, SCREEN_WIDTH - 130, 35)];
    bar.tag = 44;
    bar.delegate = self;
    bar.showsCancelButton = NO;
    [self.navigationController.navigationBar addSubview:bar];
    
    [self addNextBtnWithTitle:@"搜索"
                      fuction:@selector(searchBtn)];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49);
    [btn setTitle:@"清空搜索记录" forState:UIControlStateNormal];
    [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clearBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void)clearBtn
{
    NSFileManager *manager=[NSFileManager defaultManager];
    //文件路径
    NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"searchHistory.plist"];
    if ([manager removeItemAtPath:filepath error:nil]) {
        NSLog(@"文件删除成功");
    }
    //获取路径
    NSString * filename =[self getPlistPath];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filename];
    self.hisArr= [dic objectForKey:searchKey];
    [table reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hisArr.count;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"历史搜索记录";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"onCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"onCell"];
    }

    cell.textLabel.text = self.hisArr[indexPath.row];
    return cell;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self writeData:bar.text];
    [bar resignFirstResponder];
    HomeDetailViewController *svc = [[HomeDetailViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];

}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    bar.showsCancelButton = YES;
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    bar.showsCancelButton = NO;
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [bar resignFirstResponder];

}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    for(id bt in [searchBar.subviews[0] subviews])
    {
        if([bt isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)bt;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
            [btn setTitleColor:UIBLUE forState:UIControlStateNormal];
        }
    }
}

#pragma mark - plist
- (NSString *)getPlistPath
{
    
    //获取路径
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths  objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:@"searchHistory.plist"];
    
    //    NSString *string = [NSHomeDirectory() stringByAppendingPathComponent:@"searchHistory.plist"];
    
    return filename;
}

- (void)creatPlist
{
    NSString * filename =[self getPlistPath];
    
    //创建
    NSFileManager* fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filename]) { //如果有此文件
        [self readData];
        return;
    }
    [fm createFileAtPath:filename contents:nil attributes:nil];
    
    //插进一个dic
    NSMutableArray *searchConten = [[NSMutableArray alloc] initWithCapacity:0];
    
    
    NSDictionary *dic = @{searchKey:searchConten,
                          };
    [dic writeToFile:filename atomically:YES];
    
}
//写入
- (void)writeData:(NSString *)content
{
    
    //获取路径
    NSString * filename =[self getPlistPath];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filename];
    NSMutableArray *searchContent = [NSMutableArray arrayWithArray:[dic objectForKey:searchKey]];
    
    //最多写入十行
    if (searchContent.count == 10) {
        [searchContent removeLastObject];
    }
    [searchContent enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *objStr = [NSString stringWithFormat:@"%@",obj];
        if ([content isEqualToString:objStr]) {
            _isHasEqual = YES;
        }
    }];
    if (_isHasEqual) {
        _isHasEqual = NO;
    }else{
        [searchContent insertObject:content atIndex:0];
        
    }
    
    
    
    
    dic = @{searchKey:searchContent,
            };
    [dic writeToFile:filename atomically:YES];
    [self readData];
    
}
- (void)readData
{
    
    //    _clearnSearchHistory.hidden = NO;
    //获取路径
    NSString * filename =[self getPlistPath];
    
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filename];
    self.hisArr= [dic objectForKey:searchKey];
    
    if (_hisArr.count >= 1 ) {
    }
    
    [table reloadData];
    
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
        
    }

    //    
    
}
- (void)failure:(NSNotification *)notify
{
    
}
-(void)searchBtn
{
    
}
-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [bar resignFirstResponder];

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
