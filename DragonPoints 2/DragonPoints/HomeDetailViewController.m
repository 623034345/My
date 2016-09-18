//
//  HomeDetailViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "HomeDetailViewController.h"

@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if (view.tag == 101) {
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
        if (view.tag == 101) {
            [view removeFromSuperview];
        }
    }
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"全部商家";
    
    orderType = @"1";
//    smallCategoryId = @"60001";
    self.view.backgroundColor = UIWHITE;
    //UIBarButtonLeftItem
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];

    listArr = [NSMutableArray array];
    moreArr = [NSMutableArray array];
//    [[HttpHelper sharedInstance] moreGetdata];
    [self getData];
    [self showIndicatorView];

    shopsArr = [NSMutableArray array];

//    areas = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
//    sorts = [NSMutableArray array];

    sorts = @[@"默认排序",@"离我最近",@"返利最多",@"好评优先",@"人气优先",@"最新发布"];
    dataArr = [NSMutableArray array];
    ondataArr = [NSMutableArray array];
    //获取目录下的city.plist文件
    listArr = [NSMutableArray array];
    moreArr = [NSMutableArray array];
    areas = [NSMutableArray array];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 109, SCREEN_WIDTH, SCREEN_HEIGHT - 109) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [table addHeaderWithTarget:self action:@selector(addHeader)];
    [table addFooterWithTarget:self action:@selector(addFooter)];
    [self showIndicatorView];
    [self.view addSubview:table];
    [self creatView];
    
}
-(void)getData
{
    [[HttpHelper sharedInstance] shopGetdataWithregionId:[USER_DEFAULT objectForKey:@"regionId"]
                                         smallCategoryId:self.cid
                                               orderType:orderType
                                                     lng:[USER_DEFAULT objectForKey:@"lng"]
                                                     lat:[USER_DEFAULT objectForKey:@"lat"]];
}
//下拉刷新
-(void)addHeader
{
    [self getData];
  
    [self showIndicatorView];
}
//上拉加载
-(void)addFooter
{
    [self getData];

    [self showIndicatorView];
}
- (NSInteger)numberOfColumnsInMenu:(JSDropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    
    if (column==2) {
        
        return NO;
    }
    
    return NO;
}

-(BOOL)haveRightTableViewInColumn:(NSInteger)column{
    
    if (column==0) {
        return YES;
    }
    if (column == 1) {
        return YES;
    }
    return NO;
}

-(CGFloat)widthRatioOfLeftColumn:(NSInteger)column{
    
    if (column==0) {
        return 0.3;
    }
    if (column==1) {
        return 0.3;
    }
    
    return 1;
}

-(NSInteger)currentLeftSelectedRow:(NSInteger)column{
    
    if (column==0) {
        
        return _currentData1Index;
        
    }
    if (column==1) {
        
        return _currentData2Index;
    }
    
    return 0;
}

- (NSInteger)menu:(JSDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow{
    MoreOneModel *mod = moreArr[_currentData1Index];
    DistrictModel *mod1 = areas[_currentData2Index];
    
    if (column==0) {
        if (leftOrRight==0) {
            
            return moreArr.count;
        } else{
           
            return mod.smallccategoryOfflineList.count;
        }
    } else if (column==1)
    {
        
        if (leftOrRight==0)
        {
            
            return areas.count;
        }
        else
        {
            
            return mod1.townList.count;
            
        }
        
    } else if (column==2){
        
        return sorts.count;
    }
    
    return 0;
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    MoreOneModel *mod = moreArr[_currentData1Index];
    DistrictModel *mod1 = areas[_currentData2Index];
    
    switch (column) {
        case 0:
        {
            if (!NULL_STR(self.className)) {
                return self.className;
            }
            MoreTwoModel *tmod = mod.smallccategoryOfflineList[_currentData1Index2];
            return tmod.cname;
        }
            break;
        case 1:
        {
            townListModel *tmod = mod1.townList[_currentData2Index2];
            return tmod.townname;
            
        }
            break;
        case 2: return sorts[_currentData3Index];
            break;
            
        default:
            return nil;
            break;
    }
}

- (NSString *)menu:(JSDropDownMenu *)menu titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column==0)
    {
        NSInteger leftRow = indexPath.leftRow;
        
        if (indexPath.leftOrRight==0)
        {
            MoreOneModel *mod = moreArr[indexPath.row];
            return mod.largecname;
        }
        else
        {
            MoreOneModel *mod1 = moreArr[leftRow];
            MoreTwoModel *tmod = mod1.smallccategoryOfflineList[indexPath.row];
            name1 = tmod.cname;
            self.cid =tmod.cid;
            return tmod.cname;
        }
    }
    else if (indexPath.column==1)
    {
        if (indexPath.leftOrRight == 0)
        {
            DistrictModel *mod1 = areas[indexPath.row];
            return mod1.districtName;
            
        }
        else
        {
            DistrictModel *mod1 = areas[_currentData2Index];
            townListModel *tmod = mod1.townList[indexPath.row];
            [USER_DEFAULT setObject:tmod.townid forKey:@"regionId"];
            return tmod.townname;
            
        }
        
    }
    else
    {
        name3 =  sorts[indexPath.row];
        orderType = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        return sorts[indexPath.row];
    }
}

- (void)menu:(JSDropDownMenu *)menu didSelectRowAtIndexPath:(JSIndexPath *)indexPath {
    
    if (indexPath.column == 0)
    {
        
        if(indexPath.leftOrRight==0)
        {
            
            _currentData1Index = indexPath.row;
            
            return;
        }
        else
        {
            _currentData1Index2 = indexPath.row;
        }
        
    }
    else if(indexPath.column == 1)
    {
        if (indexPath.leftOrRight == 0)
        {
            _currentData2Index = indexPath.row;
            return;
            
        }
        else
        {
            _currentData2Index2 = indexPath.row;
            
        }
        
        
    }
    else
    {
        
        _currentData3Index = indexPath.row;
    }
    [self getData];
    [self showIndicatorView];
    if (![self.className isEqualToString:name1]) {
        self.className = @"";

    }

    NSLog(@"%@  %@  %@",name1,name2,name3);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.000001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return shopsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
    }
    
    ShopListModel *mod = shopsArr[indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:mod.shopperImage]];
    //    cell.img.image = [UIImage imageNamed:@"shiyan"];
    cell.pingfen.text = [NSString stringWithFormat:@"%@分",mod.memberId];
    [cell.Rating displayRating:[mod.memberId integerValue]];
    cell.name.text = mod.shopperName;
    cell.fenlei.text = mod.address;
    cell.num.text = mod.tradesCount;
    return cell;
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListModel *mod = shopsArr[indexPath.row];

    DetailedViewController *vc = [[DetailedViewController alloc] init];
    vc.shopperId = mod.shopperId;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)creatView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    topView.backgroundColor = UIWHITE;
    [self.view addSubview:topView];
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView5.backgroundColor = UIBLACK;
    [topView addSubview:lineView5];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, SCREEN_WIDTH/3, 40);
    btn1.tag = 1;
    [btn1 setTitle:self.className forState:UIControlStateNormal];
    [btn1 setTitleColor:UIBLACK forState:UIControlStateNormal];
    [topView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, 40);
    btn2.tag = 2;
    [btn2 setTitle:@"区域选择" forState:UIControlStateNormal];
    [btn2 setTitleColor:UIBLACK forState:UIControlStateNormal];
    [topView addSubview:btn2];
    UIImageView *backImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 - 20, 20, 20, 20)];
    backImg1.image = [UIImage imageNamed:@"choosmore"];
    [btn2 addSubview:backImg1];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(SCREEN_WIDTH/3 * 2 , 0, SCREEN_WIDTH/4, 30);
    btn3.tag = 3;
    [btn3 setTitle:@"默认排序" forState:UIControlStateNormal];
    [btn3 setTitleColor:UIBLACK forState:UIControlStateNormal];
    [topView addSubview:btn3];
    
//    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn4.frame = CGRectMake(SCREEN_WIDTH/4 * 3, 0, SCREEN_WIDTH/4, 30);
//    btn4.tag = 4;
//    [btn4 setTitle:@"交易最多" forState:UIControlStateNormal];
//    [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
//    [btn4 addTarget:self action:@selector(topBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:btn4];

    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 - 20, 20, 20, 20)];
    backImg.image = [UIImage imageNamed:@"choosmore"];
    [btn1 addSubview:backImg];

    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(btn1.frame.size.width - 1, 0, 1, 30)];
    lineView.backgroundColor = UIGRAY;
    [btn1 addSubview:lineView];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 3 -1, 0, 1, 30)];
    lineView2.backgroundColor = UIGRAY;
    [btn2 addSubview:lineView2];
    
//    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake( SCREEN_WIDTH/4 -1, 0, 1, 30)];
//    lineView3.backgroundColor = UIGRAY;
//    [btn3 addSubview:lineView3];
    
//    //地址
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, SCREEN_WIDTH - 50, 26)];
//    lab.text = @"上海市浦东新区世纪大道2000号";
//    [topView addSubview:lab];
//    
//    UIButton *shuaxin = [UIButton buttonWithType:UIButtonTypeCustom];
//    shuaxin.frame = CGRectMake(SCREEN_WIDTH - 40, 30, 26, 26);
//    [shuaxin setImage:[UIImage imageNamed:@"UpdateLocation"] forState:UIControlStateNormal];
//    [topView addSubview:shuaxin];
    
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];
    [moreArr removeAllObjects];
    [areas removeAllObjects];
    [dataArr removeAllObjects];
    [shopsArr removeAllObjects];
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([SHOPS isEqualToString:key] )
    {
        
        NSDictionary *successDic = [notify userInfo][SHOPS];
        //        NSLog(@"%@",successDic);
        NSArray *shopArr = successDic[@"shopperList"];
        [shopArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ShopListModel   *smod = [[ShopListModel alloc] init];
            [smod setValuesForKeysWithDictionary:obj];
            [shopsArr addObject:smod];
        }];
        
        NSArray *sourceArray = successDic[@"exchangeProductList"];
        
        [sourceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             ShopsModel *mod =[[ShopsModel alloc]init];
             [mod setValuesForKeysWithDictionary:obj];
             [dataArr addObject:mod];
         }];
        NSArray *sourceArray1  = successDic[@"districtAndTownList"];
        [sourceArray1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DistrictModel *disMod = [[DistrictModel alloc] init];
            [disMod setValuesForKeysWithDictionary:obj];
            NSArray *huodong  = obj[@"townList"];
            NSMutableArray *arr1 = [NSMutableArray array];
            [huodong enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                townListModel *floor = [[townListModel alloc] init];
                [floor setValuesForKeysWithDictionary:obj];
                [arr1 addObject:floor];
            }];
            disMod.townList = arr1;
            [areas addObject:disMod];
            
        }];
        NSDictionary *dic = successDic[@"allCategoryOffline"];
        NSArray *sourceArray2 = dic[@"categoryOfflineList"];
        if (![sourceArray2 isKindOfClass:[NSNull class]]) {
            for (NSDictionary *wdic in sourceArray2)
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
    if (moreArr.count >0 && areas.count > 0) {
        menu = [[JSDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:45];
        menu.indicatorColor = [UIColor redColor];
        menu.separatorColor = [UIColor grayColor];
        menu.textColor = [UIColor blackColor];
        menu.dataSource = self;
        menu.delegate = self;
        [self.view addSubview:menu];
    }
    
    
}

- (void)failure:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];
    [self showAlertWithPoint:0
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];
}
//消息
-(void)xiaoxi
{
    
}
//顶部选择
-(void)topBtn:(UIButton*)button
{
    if (button.titleLabel.text) {
        
    }
}
//返回
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
