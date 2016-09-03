//
//  ShopDatailViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "ShopDatailViewController.h"

@interface ShopDatailViewController ()<SDCycleScrollViewDelegate>

@end

@implementation ShopDatailViewController
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
    // 情景二：采用网络图片实现
    imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    [self creatView];
}
-(void)creatView
{
    self.navigationItem.title =@"商品详情";
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
    [self addNextBtnWithImageNormal:@"xiaoxi"
                            fuction:@selector(xiaoxi)];

//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 30)];
//    view.backgroundColor = UICOLOR_HEXA(0x2d3e52, 0.5);
//    [self.view addSubview:view];
//    
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
////    [backBtn setBackgroundColor:UIBLUE];
//    backBtn.frame = CGRectMake(10, 5, 10, 17);
//    [backBtn setImage:[UIImage imageNamed:@"bbb"] forState:UIControlStateNormal];
//    [backBtn addTarget:self
//                action:@selector(localMap)
//      forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:backBtn];
//    //消息
//    
//    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    saveBtn.frame = CGRectMake(SCREEN_WIDTH - 40, 5, 20, 20);
//    [saveBtn setImage:[UIImage imageNamed:@"bxx"]
//                       forState:UIControlStateNormal];
//    [saveBtn addTarget:self
//                action:@selector(xiaoxi)
//      forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:saveBtn];
//    
//    UILabel *lab = [[UILabel alloc] init];
//    lab.frame = CGRectMake(SCREEN_WIDTH / 2 - 40, 0, 80, 30);
//    lab.text = @"商品详情";
//    lab.textColor = UIWHITE;
//    [view addSubview:lab];
    UIView *bottmView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    bottmView.backgroundColor = UIWHITE;
    [self.view addSubview:bottmView];
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    topImg.image = [UIImage imageNamed:@"zf"];
    [bottmView addSubview:topImg];
    
//    UIButton *fBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    fBtn.frame = CGRectMake(10, 0, 47, 47);
//    [fBtn setImage:[UIImage imageNamed:@"Share"] forState:UIControlStateNormal];
//    [fBtn addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
//    [bottmView addSubview:fBtn];
//    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 47, 17)];
//    lab1.font = [UIFont systemFontOfSize:11];
//    lab1.textAlignment = NSTextAlignmentCenter;
//    lab1.text = @"分享";
//    [bottmView addSubview:lab1];
//    
//    UIButton *sBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    sBtn.frame = CGRectMake(57, 0, 47, 47);
//    [sBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
//    [sBtn addTarget:self action:@selector(sBtn) forControlEvents:UIControlEventTouchUpInside];
//    [bottmView addSubview:sBtn];
//    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(57, 30, 47, 17)];
//    lab2.font = [UIFont systemFontOfSize:11];
//    lab2.textAlignment = NSTextAlignmentCenter;
//    lab2.text = @"收藏";
//    [bottmView addSubview:lab2];
//    
//    UIButton *dBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    dBtn.frame = CGRectMake(57, 0, 47, 47);
//    [dBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
//    [dBtn addTarget:self action:@selector(dBtn) forControlEvents:UIControlEventTouchUpInside];
//    [bottmView addSubview:dBtn];
//    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(104, 30, 47, 17)];
//    lab3.font = [UIFont systemFontOfSize:11];
//    lab3.textAlignment = NSTextAlignmentCenter;
//    lab3.text = @"店铺";
//    [bottmView addSubview:lab3];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(130, 2, 2, 47)];
    line.backgroundColor = UICOLOR_HEX(0x969fa8);
    [bottmView addSubview:line];
    
    UIButton *jBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jBtn.frame = CGRectMake(131, 0, (SCREEN_WIDTH - 131)/2, 49);
    [jBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [jBtn setTitleColor:UICOLOR_HEX(0xea4b35) forState:UIControlStateNormal];
    [jBtn addTarget:self action:@selector(jBtn) forControlEvents:UIControlEventTouchUpInside];
    [bottmView addSubview:jBtn];
    
    UIButton *lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lBtn.frame = CGRectMake((SCREEN_WIDTH - 131)/2 + 131, 0, (SCREEN_WIDTH - 131)/2, 49);
    [lBtn setBackgroundColor:UICOLOR_HEX(0xea4b35)];
    [lBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [lBtn addTarget:self action:@selector(lBtn) forControlEvents:UIControlEventTouchUpInside];
    [bottmView addSubview:lBtn];
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    if (section == 1) {
        return 5;
    }
    return imagesURLStrings.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ShopDtailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopDtailTableViewCell"];
            if (!cell ) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"ShopDtailTableViewCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellAccessoryNone;
            }
            [cell.fenxiang addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell.shoucang addTarget:self action:@selector(sBtn) forControlEvents:UIControlEventTouchUpInside];
            cell.scrollView.delegate = self;
            cell.scrollView.imageURLStringsGroup = imagesURLStrings;
            return cell;
        }
        if (indexPath.row == 1) {
            UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cellkkk"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellkkk"];
                cell.selectionStyle = UITableViewCellAccessoryNone;
                
                UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yd"]];
                img.frame = CGRectMake(10, 5, 20, 20);
                [cell addSubview:img];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, 50, 20)];
                lab.font = [UIFont systemFontOfSize:14];
                lab.text = @"15云币";
                [cell addSubview:lab];
                
                UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yd"]];
                img1.frame = CGRectMake(85, 5, 20, 20);
                [cell addSubview:img1];
                UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 50, 20)];
                lab1.font = [UIFont systemFontOfSize:14];
                lab1.text = @"15云豆";
                [cell addSubview:lab1];

            }
            return cell;
        }
        if (indexPath.row == 2) {
            PartakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartakeTableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PartakeTableViewCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellAccessoryNone;
            }
            cell.touxiang.layer.masksToBounds = YES;
            cell.touxiang.layer.cornerRadius = 15;
            cell.touxiang.image = [UIImage imageNamed:@"shiyan"];
            
            cell.shopImg.image = [UIImage imageNamed:@"shiyan"];
            [cell.more addTarget:self action:@selector(moreBtn) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTT"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTT"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            line.backgroundColor = UICOLOR_HEX(0x969fa8);
            [cell addSubview:line];
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH -10, 20)];
            name.font = [UIFont systemFontOfSize:12];
            name.tag = 111;
            [cell addSubview:name];
        }
        UILabel *lab = (UILabel *)[cell viewWithTag:111];
        lab.text = @"这是一个神奇的商品          神奇的名字";
        
        return cell;
    }
    if (indexPath.section == 2) {
        ImageTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageTTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageTTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        [cell.img sd_setImageWithURL:[NSURL URLWithString:[imagesURLStrings objectAtIndex:indexPath.row]]];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 280;
            
        }
        if (indexPath.row == 1)
        {
            return 30;
            
        }
        else if (indexPath.row == 2)
        {
            return 170;
        }
    }
    if (indexPath.section == 1) {
        return 20;
    }
 
    return 320;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0000001;
}



#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSMutableArray *photos = [NSMutableArray array];
    for (int i=0; i<imagesURLStrings.count; i ++) {
        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[imagesURLStrings objectAtIndex:i]]]];
    }
    self.photosImg = photos;
    //创建MWPhotoBrowser ，要使用initWithDelegate方法，要遵循MWPhotoBrowserDelegate协议
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    //设置当前要显示的图片
    [browser setCurrentPhotoIndex:0];
    
    //push到MWPhotoBrowser
    [self.navigationController pushViewController:browser animated:YES];
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photosImg.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photosImg.count) {
        return [self.photosImg objectAtIndex:index];
    }
    return nil;
}
-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
//立即抢购
-(void)lBtn
{
    if (NULL_STR([USER_DEFAULT objectForKey:USERID]))
    {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:lvc animated:NO];
    }
    else
    {
        PayOfflineViewController *pvc = [[PayOfflineViewController alloc] init];
        [self.navigationController pushViewController:pvc animated:YES];
    }

}
//加入购物车
-(void)jBtn
{
    if (NULL_STR([USER_DEFAULT objectForKey:USERID]))
    {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:lvc animated:NO];
    }
    else
    {
        
    }
}

//收藏
-(void)sBtn
{
    if (NULL_STR([USER_DEFAULT objectForKey:USERID]))
    {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:lvc animated:NO];
    }
}
//分享
-(void)shareBtn
{
    //1、创建分享参数
    NSArray* imageArray = @[@"shareImg.png"];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:[UIImage imageNamed:[imageArray objectAtIndex:0]]
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }];

    }
}
//消息
-(void)xiaoxi
{
    
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

-(void)moreBtn
{
    EvaluateViewController *evc = [[EvaluateViewController alloc] init];
    [self.navigationController pushViewController:evc animated:YES];
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
