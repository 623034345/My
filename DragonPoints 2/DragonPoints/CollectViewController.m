//
//  CollectViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "CollectViewController.h"

@interface CollectViewController ()

@end

@implementation CollectViewController
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
    type = 1;
//    isKai = NO;
//    btnArr =[NSMutableArray array];
//    //创建一个数组
//    _DataArray=[[NSMutableArray alloc] init];
//    
//    for (int i=0;i<=5 ; i++) {
//        NSMutableArray *array=[[NSMutableArray alloc] init];
//        for (int j=0; j<=5;j++) {
//            NSString *string=[NSString stringWithFormat:@"%i组-%i行",i,j];
//            [array addObject:string];
//        }
//        
//        NSString *string=[NSString stringWithFormat:@"第%i分组",i];
//        
//        //创建一个字典 包含数组，分组名，是否展开的标示
//        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:array,DIC_ARARRY,string,DIC_TITILESTRING,[NSNumber numberWithInt:0],DIC_EXPANDED,nil];
//        
//        
//        //将字典加入数组
//        [_DataArray addObject:dic];
//    }
    self.navigationItem.title = @"收藏";
//    [self topView];
    table =[[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];

}
-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
//-(void)topView
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 30)];
//    view.backgroundColor = UIWHITE;
//    [self.view addSubview:view];
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH, 1)];
//    lineView.backgroundColor = UIBLACK;
//    [view addSubview:lineView];
//    NSArray *arr = @[@"收藏商品",@"收藏店铺"];
//    for (int i = 0; i<arr.count; i ++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(i * SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 29);
//        [btn setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
//        btn.tag = i + 1;
//
//        [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
//
//        if (i == 0) {
//            [btn setTitleColor:UIRED forState:UIControlStateNormal];
//
//        }
//
//
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [btnArr addObject:btn];
//
//        [view addSubview:btn];
//    }
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (isKai) {
//        return 5;
//        
//    }

//    return _DataArray.count;
//    if (type == 2) {
//        NSMutableDictionary *dic=[_DataArray objectAtIndex:section];
//        NSArray *array=[dic objectForKey:DIC_ARARRY];
//        
//        //判断是收缩还是展开
//        if ([[dic objectForKey:DIC_EXPANDED]intValue]) {
//            return array.count;
//        }else
//        {
//            return 0;
//        }
//    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    CshopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CshopTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CshopTableViewCell" owner:self options:nil] lastObject];
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    cell.img.image = [UIImage imageNamed:@"shiyan"];
    cell.name.text = @"不要再看了我就是一个商店名字而已";
    cell.num.text = @"12件商品";
    cell.pf.text = @"3.5分";
    [cell.rating displayRating:3.5];
//    NSArray *array=[[_DataArray objectAtIndex:indexPath.section] objectForKey:DIC_ARARRY];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (type == 1) {
//        return 1;
//    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (type == 1) {
        return 0.00001;
//    }
//    //设置区头的高度
//    return 60 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (type == 2) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
        view.backgroundColor = UIWHITE;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 30, 30)];
        img.image = [UIImage imageNamed:@"dd"];
        [view addSubview:img];
        
        UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 100, 30)];
        nameLab.text = @"美人驾到";
        [view addSubview:nameLab];
        
        RatingBarView *rating = [[RatingBarView alloc] initWithFrame:CGRectMake(70, 30, 150, 30)];
        [rating setImageDeselected:@"star2"
                      halfSelected:@"starB"
                      fullSelected:@"rating_show"
                       andDelegate:self];
        [rating displayRating:3.5];
        rating.isBig = YES;
        rating.isIndicator = YES;
        [view addSubview:rating];
        
        
        UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(200, 20, 50, 30)];
        numLab.text = @"3.5分";
        [view addSubview:numLab];
        
        UILabel *shopLab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 170, 5,  SCREEN_WIDTH - (SCREEN_WIDTH - 170) - 10, 30)];
        shopLab.textAlignment = NSTextAlignmentRight;
        shopLab.text = @"12件商品";
        [view addSubview:shopLab];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
        [btn addTarget:self action:@selector(dk:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = section;
        [view addSubview:btn];
        
        //上显示线
        UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, -1, view.frame.size.width,1)];
        label1.backgroundColor=[UIColor blueColor];
        [view addSubview:label1];
        
        //下显示线
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, view.frame.size.height-1, view.frame.size.width,1)];
        label.backgroundColor=[UIColor blueColor];
        [view addSubview:label];
        return view;
    }
    return nil;
}
//-(void)dk:(UIButton *)button
//{
//
//     NSInteger section= button.tag;//取得tag知道点击对应哪个块
//    [self collapseOrExpand:section];
//    
//    //刷新tableview
//    [table reloadData];
//}
-(void)collapseOrExpand:(NSInteger)section{
    NSMutableDictionary *dic=[_DataArray objectAtIndex:section];
    
    int expanded=[[dic objectForKey:DIC_EXPANDED] intValue];
    if (expanded) {
        [dic setValue:[NSNumber numberWithInt:0]forKey:DIC_EXPANDED];
    }else
    {
        [dic setValue:[NSNumber numberWithInt:1]forKey:DIC_EXPANDED];
    }
}
//返回指定节是否是展开的
-(int)isExpanded:(int)section
{
    NSDictionary *dic=[_DataArray objectAtIndex:section];
    int expanded=[[dic objectForKey:DIC_EXPANDED] intValue];
    return expanded;
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
//-(void)btnClick:(UIButton *)button
//{
//    type = button.tag ;
//    for (UIButton *btn in btnArr) {
//        if (button.tag == btn.tag) {
//            [btn setTitleColor:UIRED forState:UIControlStateNormal];
//        }
//        else
//        {
//            [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
//
//        }
//    }
//    [table reloadData];
//}
- (void)ratingChanged:(float)newRating
{
    
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
