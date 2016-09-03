//
//  EshopViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "EshopViewController.h"

@interface EshopViewController ()

@end

@implementation EshopViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *view in self.navigationController.view.subviews) {
        if (view.tag == 205) {
            [view setHidden:NO];
        }
    }
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];
    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:NO];
    
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
    for (UIView *view in self.navigationController.view.subviews) {
        if (view.tag == 205) {
            [view setHidden:YES];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIWHITE;
    //UIBarButtonLeftItem
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 30, 30);
//    [backBtn setTitle:@"郑州" forState:UIControlStateNormal];
//    backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20,0  , 0);
//    [backBtn setTitleColor:UIBLACK forState:UIControlStateNormal];
//    [backBtn addTarget:self
//                action:@selector(localMap)
//      forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weizhi"]];
//    img.frame = CGRectMake(23, 10, 15, 10);
//    [backBtn addSubview:img];
//    self.navigationItem.leftBarButtonItem = backBtnItem;
//    
//    //搜索
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(60, 20, SCREEN_WIDTH - 120, 35);
//    btn.backgroundColor = UIWHITE;
//    btn.layer.masksToBounds = YES;
//    btn.tag = 205;
//    btn.layer.cornerRadius = 10;
//    [self.navigationController.view addSubview:btn];
//    UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo"]];
//    img1.frame = CGRectMake(10, 10, 20, 20);
//    [btn addSubview:img1];
    
    
    //消息
    [self addNextBtnWithImageNormal:@"xiaoxi1"
                            fuction:@selector(xiaoxi)];
    self.seletedOn = 1;
    self.seletedTop = 1;
    self.isOne = YES;
    [self CreatBtn];
    [self creatTopBtn];
    _imgArr = [NSMutableArray arrayWithObjects:@"yf",@"yf1",@"yf2",@"yf3",@"yf4",@"yf5", nil];
    //初始化
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //该方法也可以设置itemSize
    flowLayout.itemSize =CGSizeMake((SCREEN_WIDTH - 100) / 3 - 30, 130);
    _CollectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(100, 95, SCREEN_WIDTH - 90, SCREEN_HEIGHT - 144) collectionViewLayout:flowLayout];

    _CollectionView.delegate=self;
    _CollectionView.dataSource =self;
    _CollectionView.backgroundColor=[UIColor whiteColor];
    [_CollectionView registerClass:[EshopCollectionViewCell class] forCellWithReuseIdentifier:@"EshopCollectionViewCell"];
    [_CollectionView registerNib:[UINib nibWithNibName:@"EshopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"EshopCollectionViewCell"];

    [self.view addSubview:_CollectionView];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imgArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"裙装",@"连衣裙",@"半身裙",@"上衣",@"衬衫",@"针织衫", nil];
    EshopCollectionViewCell *cell = (EshopCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"EshopCollectionViewCell" forIndexPath:indexPath];

    cell.lab.text = [arr objectAtIndex:indexPath.row];
    cell.img.image = [UIImage imageNamed:[_imgArr objectAtIndex:indexPath.row]];
    
    
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 100) / 3, 130);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EstoreViewController *svc = [[EstoreViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];

}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1,0, 0);
}
-(void)CreatBtn
{
    self.postersArr = [NSMutableArray arrayWithObjects:@"女装",@"男装",@"鞋靴",@"箱包",@"美妆",@"数码家电",@"家具家纺",@"孕妇必备",@"玩具",@"户外运动", nil];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, 100, SCREEN_HEIGHT - 113)];
    scrollView.backgroundColor = UIWHITE;
    //Horizontal 水平滑动条
    scrollView.showsHorizontalScrollIndicator = NO;
    //Vertical垂直滑动条
    scrollView.showsVerticalScrollIndicator = NO;
    UIButton*btn;
    for (int i = 0; i< self.postersArr.count; i++)
    {
        btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 65 * i + 5 , 100, 60);
        [btn setBackgroundColor:UICOLOR_HEX(0xf9f9f9)];
        btn.tag = i + 1;
        [btn setTitle:[self.postersArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(flBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [scrollView addSubview:btn];
 
        if (btn.tag == self.seletedOn) {
            [btn setTitleColor:UIRED forState:UIControlStateNormal];
            smallView  = [[UIView alloc] init];
            smallView.backgroundColor = UIRED;
            smallView.frame = CGRectMake(0, 0, 5, 60);
            [btn addSubview:smallView];
            
        }
        else
        {
            [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [smallView removeFromSuperview];

        }
 
        


    }
    scrollView.contentSize = CGSizeMake(0, self.postersArr.count *65);
    scrollView.contentOffset = CGPointMake(0, self.seletedOn * 10);
    scrollView.pagingEnabled = NO;
    [self.view addSubview:scrollView];


}
-(void)creatTopBtn
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 64, SCREEN_WIDTH - 100, 31)];
    view.backgroundColor = UIWHITE;
    [self.view addSubview:view];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 29, SCREEN_WIDTH - 100, 2)];
    lineView.backgroundColor = UICOLOR_HEX(0xf9f9f9);
    [view addSubview:lineView];
    UIButton *topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.frame = CGRectMake(0, 0, view.frame.size.width / 2, 30);
    if (_seletedTop == 1) {
        [topBtn setTitleColor:UIRED forState:UIControlStateNormal];

    }
    else
    {
        [topBtn setTitleColor:UIBLACK forState:UIControlStateNormal];

    }
    [topBtn setTitle:@"兑换商品" forState:UIControlStateNormal];
    topBtn.tag = 1;
    [topBtn addTarget:self action:@selector(topBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:topBtn];
    UIButton *topBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn1.frame = CGRectMake(view.frame.size.width / 2, 0, view.frame.size.width / 2, 30);
    [topBtn1 setTitleColor:UIBLACK forState:UIControlStateNormal];
    if (_seletedTop == 2) {
        [topBtn1 setTitleColor:UIRED forState:UIControlStateNormal];
        
    }
    else
    {
        [topBtn1 setTitleColor:UIBLACK forState:UIControlStateNormal];
        
    }
    [topBtn1 setTitle:@"特价商品" forState:UIControlStateNormal];
    topBtn1.tag = 2;
    [topBtn1 addTarget:self action:@selector(topBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:topBtn1];
 
    xiao = [[UIView alloc]init];
    xiao.frame =  CGRectMake(((SCREEN_WIDTH - 100)/2 - 70 ) / 2, 29, 70, 2);
   
    //    [button setTitleColor:UIRED forState:UIControlStateNormal];
    if (_seletedTop == 1) {
        xiao.center=CGPointMake(topBtn.center.x, 29);

    }
    else
    {
        
        xiao.center=CGPointMake(topBtn1.center.x, 29);
    }

        xiao.backgroundColor = UIRED;
        [view addSubview:xiao];

}

//顶部按钮
-(void)topBtn:(UIButton *)button
{
//    TABLE.tag=button.tag;
//    [TABLE reloadData];
    _seletedTop = button.tag;
 
    [self creatTopBtn];

}
//左侧按钮
-(void)flBtn:(UIButton *)button
{
    NSLog(@"%@",button.titleLabel.text);
    UIButton *btn  = (UIButton *)[self.view viewWithTag:button.tag]; ;
    if (button.tag == self.seletedOn) {
        [btn setTitleColor:UIRED forState:UIControlStateNormal];
        smallView  = [[UIView alloc] init];
        smallView.backgroundColor = UIRED;
        smallView.frame = CGRectMake(0, 0, 5, 60);
        [btn addSubview:smallView];
    }
    else
    {
        [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
        [smallView removeFromSuperview];


    }
    self.seletedOn = button.tag;
    [self CreatBtn];


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
//消息
-(void)xiaoxi
{
    
}
//定位
-(void)localMap
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
