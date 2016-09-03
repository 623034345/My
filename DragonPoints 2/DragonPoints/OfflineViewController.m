//
//  OfflineViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/1.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "OfflineViewController.h"
#import "SDCycleScrollView.h"
@interface OfflineViewController ()<SDCycleScrollViewDelegate>

@end

@implementation OfflineViewController
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
    [self getdata];
//    imagesURLStrings = @[
//                         @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                         @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    imagesURLStrings = [NSMutableArray array];
    bottomimagesURLStrings = [NSMutableArray array];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113)];
    table.delegate = self;
    table.dataSource = self;
    [table addHeaderWithTarget:self action:@selector(addHeader)];
    [table addFooterWithTarget:self action:@selector(addFooter)];
    [self showIndicatorView];
    [self.view addSubview:table];
    [self creatView];
    
    
    


}
//下拉刷新
-(void)addHeader
{
    [self getdata];
    [self showIndicatorView];
}
//上拉加载
-(void)addFooter
{
    [self getdata];
    [self showIndicatorView];
}
-(void)creatView
{
    self.navigationItem.title =@"商品详情";
    dataDic = [NSDictionary dictionary];
    lastDataArr = [NSMutableArray array];
    productCommonArr = [NSMutableArray array];
    
    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
    //消息
    [self addNextBtnWithImageNormal:@"xiaoxi1"
                            fuction:@selector(xiaoxi)];
    UIView *bottmView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 49, SCREEN_WIDTH, 49)];
    bottmView.backgroundColor = UIWHITE;
    [self.view addSubview:bottmView];
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
    topImg.image = [UIImage imageNamed:@"zf"];
    [bottmView addSubview:topImg];
    
    UIButton *ybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ybtn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 49);
    [ybtn setTitle:@"预售" forState:UIControlStateNormal];
    [ybtn setTitleColor:UIBLUE forState:UIControlStateNormal];
    [ybtn addTarget:self action:@selector(ybtn) forControlEvents:UIControlEventTouchUpInside];

    [bottmView addSubview:ybtn];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 1, 2, 1, 47)];
//    line.backgroundColor = UICOLOR_HEX(0x969fa8);
//    [bottmView addSubview:line];
    
//    UIButton *jBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    jBtn.frame = CGRectMake(131, 0, (SCREEN_WIDTH - 131)/2, 49);
//    [jBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
//    [jBtn setTitleColor:UICOLOR_HEX(0xea4b35) forState:UIControlStateNormal];
//    [jBtn addTarget:self action:@selector(jBtn) forControlEvents:UIControlEventTouchUpInside];
//    [bottmView addSubview:jBtn];
    
    UIButton *lBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lBtn.frame = CGRectMake((SCREEN_WIDTH)/2, 0, (SCREEN_WIDTH)/2, 49);
    [lBtn setBackgroundColor:UICOLOR_HEX(0xea4b35)];
    [lBtn setTitle:@"支付/买单" forState:UIControlStateNormal];
    [lBtn addTarget:self action:@selector(lBtn) forControlEvents:UIControlEventTouchUpInside];
    [bottmView addSubview:lBtn];
    
}
-(void)getdata
{
    [[HttpHelper sharedInstance] offlineShopsDailWithproductId:self.productId];
}
-(void)xiaBtn:(UIButton *)button
{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataDic.count >0) {
        if (section == 0) {
            if (self.seletedOn == 1) {
                return 3;
                
            }
            else
            {
                return 2;
                
            }
        }
        if (section == 1) {
            return bottomimagesURLStrings.count;
        }
    }
     return 0;
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
//            NSInteger height = SCREEN_WIDTH;
            cell.imgHeight = [NSLayoutConstraint constraintWithItem:cell.scrollView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:SCREEN_WIDTH];;
            [cell.fenxiang addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
            [cell.shoucang addTarget:self action:@selector(sBtn) forControlEvents:UIControlEventTouchUpInside];
            cell.scrollView.delegate = self;
            if (productCommonArr.count > 0) {
                cell.scrollView.imageURLStringsGroup = imagesURLStrings;

                ProductCommonModel *mod = productCommonArr[0];
                cell.name.text = mod.productname;
                if (self.seletedOn == 1) {
                    cell.rPrice.text = [NSString stringWithFormat:@"￥%@",mod.discountprice];

                }
                if (self.seletedOn == 2) {
                    cell.rPrice.text = [NSString stringWithFormat:@"%@龙点币",mod.discountprice];
                    
                }
                //中划线
                
                NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
                if (NULL_STR(mod.productprice)) {
                    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:mod.productprice  attributes:attribtDic];
                    cell.hPrice.attributedText = attribtStr;
                }
              
            }
            return cell;
        }
        if (self.seletedOn == 1) {
            if (indexPath.row == 1) {
                UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cellkkk"];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellkkk"];
                    cell.selectionStyle = UITableViewCellAccessoryNone;
                    
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 20)];
                    lab.font = [UIFont systemFontOfSize:14];
                    lab.tag = 53;
                    [cell addSubview:lab];
                    
                    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(150, 5, 150, 20)];
                    lab1.font = [UIFont systemFontOfSize:14];
                    lab1.tag = 54;
                    [cell addSubview:lab1];
                    
                }
                if (productCommonArr.count > 0) {
                    ProductCommonModel *mod = productCommonArr[0];
                    UILabel *lab = (UILabel *)[cell viewWithTag:53];
                    UILabel *lab1 = (UILabel *)[cell viewWithTag:54];
                    lab.text = [NSString stringWithFormat:@"分享龙点币 %@",mod.coinnum];
                    lab1.text = [NSString stringWithFormat:@"分享龙豆 %@",mod.beansnum];
                    
                    
                }
                return cell;
            }
        }
     
  //TellTableViewCell
//        if (indexPath.row == 2) {
//            TellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TellTableViewCell"];
//            if (!cell) {
//                cell = [[[NSBundle mainBundle] loadNibNamed:@"TellTableViewCell" owner:self options:nil] lastObject];
//                cell.selectionStyle = UITableViewCellAccessoryNone;
//            }
//            [cell.mapBtn addTarget:self action:@selector(mapBtn) forControlEvents:UIControlEventTouchUpInside];
//            [cell.tellBtn addTarget:self action:@selector(tellBtn) forControlEvents:UIControlEventTouchUpInside];
//
//            cell.content.text = dataDic[@"shopperAddress"];
//            return cell;
//        }
        NSInteger b = 0;
        if (self.seletedOn == 1)
        {
            b = 2;
        }
        if (self.seletedOn == 2)
        {
            b = 1;
        }
        if (self.seletedOn == -1)
        {
            b = -1;
        }
        if (indexPath.row == b) {
            PartakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartakeTableViewCell"];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"PartakeTableViewCell" owner:self options:nil] lastObject];
                cell.selectionStyle = UITableViewCellAccessoryNone;
            }
            if (lastDataArr.count >0) {
                LastCommentModel *mod = lastDataArr[0];
                ProductCommonModel *mod1 = productCommonArr[0];

                cell.touxiang.layer.masksToBounds = YES;
                cell.touxiang.layer.cornerRadius = 15;
                [cell.touxiang sd_setImageWithURL:[NSURL URLWithString:mod.memberHeadImageUrl]];
                cell.content.text = mod.thecomment;
                [cell.rating displayRating:[mod1.givescorecount floatValue]];
                cell.numsP.text = [NSString stringWithFormat:@"共%@人参与了评价",mod1.givescorecount];
                cell.name.text = [NSString stringWithFormat:@"%@  %@",mod.commentuserid,mod.commenttime];
            }
            
            [cell.more addTarget:self action:@selector(moreBtn) forControlEvents:UIControlEventTouchUpInside];

            return cell;
        }
    }
//    if (indexPath.section == 1) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTT"];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTT"];
//            cell.selectionStyle = UITableViewCellAccessoryNone;
//            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
//            line.backgroundColor = UICOLOR_HEX(0x969fa8);
//            [cell addSubview:line];
//            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH -10, 20)];
//            name.font = [UIFont systemFontOfSize:12];
//            name.tag = 111;
//            [cell addSubview:name];
//        }
//        UILabel *lab = (UILabel *)[cell viewWithTag:111];
//        lab.text = @"这是一个神奇的商品          神奇的名字";
//        return cell;
//    }
    if (indexPath.section == 1) {
        ImageTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageTTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ImageTTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        [cell.img sd_setImageWithURL:[NSURL URLWithString:[bottomimagesURLStrings objectAtIndex:indexPath.row]]];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return SCREEN_WIDTH + 100;
            
        }
        if (self.seletedOn == 1) {
            if (indexPath.row == 1)
            {
                return 30;
                
            }
            else if (indexPath.row == 2)
            {
                return 170;
            }

        }
        if (self.seletedOn == 2) {
 
            if (indexPath.row == 1)
            {
                return 170;
            }
            
        }
    }
//    if (indexPath.section == 1) {
//        return 20;
//    }
    
    return SCREEN_WIDTH;
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
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];
    [productCommonArr removeAllObjects];
    [lastDataArr removeAllObjects];
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([OFSHOPS isEqualToString:key] )
    {

        dataDic = [notify userInfo][OFSHOPS];
//        NSLog(@"==%@",dataDic);
        NSDictionary *lastDic = dataDic[@"lastComment"];
        LastCommentModel *mod = [[LastCommentModel alloc] init];
        [mod setValuesForKeysWithDictionary:lastDic];
        [lastDataArr addObject:mod];
        NSDictionary *productDic = dataDic[@"productCommon"];
        ProductCommonModel *mod1 = [[ProductCommonModel alloc] init];
        [mod1 setValuesForKeysWithDictionary:productDic];
        [productCommonArr addObject:mod1];
        imagesURLStrings = dataDic[@"aboveMainImageList"];
        bottomimagesURLStrings = dataDic[@"aboveMainImageList"];
        if ([productDic[@"isExchange"] isEqualToString:@"Y"]) {
            self.seletedOn = 2;
        }
        else
        {
            self.seletedOn = 1;

        }

    }
    [table reloadData];
    
    
}
- (void)failure:(NSNotification *)notify
{
    
}

-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
//预售
-(void)ybtn
{
    if (NULL_STR([USER_DEFAULT objectForKey:USERID]))
    {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:lvc animated:NO];
    }
    else
    {
        [USER_DEFAULT setObject:@"1" forKey:@"boa"];
        PreSaleViewController *pvc = [[PreSaleViewController alloc] init];
        pvc.onType = 1;
        ProductCommonModel *mod = productCommonArr[0];
        pvc.productId = self.productId;
        pvc.priceStr = [NSString stringWithFormat:@"%@",mod.discountprice];
        [self.navigationController pushViewController:pvc animated:YES];
    }
  
   

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
        [USER_DEFAULT setObject:@"2" forKey:@"boa"];
        ProductCommonModel *mod = productCommonArr[0];
        //    SpecificationViewController *svc = [[SpecificationViewController alloc] init];
        //    [self.navigationController pushViewController:svc animated:YES];
        PreSaleViewController *pvc = [[PreSaleViewController alloc] init];
        pvc.priceStr = [NSString stringWithFormat:@"%@",mod.discountprice];
        pvc.productId = self.productId;
        pvc.onType = 2;
        [self.navigationController pushViewController:pvc animated:YES];
    }
 
}
////加入购物车
//-(void)jBtn
//{
//    
//}

//收藏
-(void)sBtn
{
    
}
//分享
-(void)shareBtn
{
    [self sharedWithcontArr:@[@"154756415"]];
//    //1、创建分享参数
//    NSArray* imageArray = @[@"shareImg.png"];
//    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//    if (imageArray) {
//        
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupShareParamsByText:@"分享内容"
//                                         images:[UIImage imageNamed:[imageArray objectAtIndex:0]]
//                                            url:[NSURL URLWithString:@"http://mob.com"]
//                                          title:@"分享标题"
//                                           type:SSDKContentTypeAuto];
//        //2、分享（可以弹出我们的分享菜单和编辑界面）
//        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
//                                 items:nil
//                           shareParams:shareParams
//                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                       
//                       switch (state) {
//                           case SSDKResponseStateSuccess:
//                           {
//                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                   message:nil
//                                                                                  delegate:nil
//                                                                         cancelButtonTitle:@"确定"
//                                                                         otherButtonTitles:nil];
//                               [alertView show];
//                               break;
//                           }
//                           case SSDKResponseStateFail:
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:[NSString stringWithFormat:@"%@",error]
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"OK"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show];
//                               break;
//                           }
//                           default:
//                               break;
//                       }
//                   }];
//        
//    }
}
-(void)tellBtn
{
    NSString *phoneNum = @"15538996517";// 电话号码
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNum]];
    [[UIApplication sharedApplication] openURL:phoneURL];
}
//消息
-(void)xiaoxi
{

}
-(void)moreBtn
{
    EvaluateViewController *evc = [[EvaluateViewController alloc] init];
    [self.navigationController pushViewController:evc animated:YES];
}
-(void)mapBtn
{
    PhoneGPSViewController *mvc = [[PhoneGPSViewController alloc] init];
    mvc.locaLatitude = locaLatitude;
    mvc.locaLongitude = locaLongitude;
    mvc.purpose = dataDic[@"shopperAddress"];
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
