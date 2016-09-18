//
//  DetailedViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "DetailedViewController.h"
#import "SDCycleScrollView.h"
@interface DetailedViewController ()<SDCycleScrollViewDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@end

@implementation DetailedViewController
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
    _geocodesearch.delegate=self;//BMKSearch的协议

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    _geocodesearch.delegate=nil;//BMKSearch的协议

    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    //初始化BMKLocationService
    //启动LocationService
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _geocodesearch.delegate = self;//设置代理为self

    a = 1;
    b = 1;
    referralArr = [NSMutableArray arrayWithObjects:@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa",@"dsa", nil];

    imagesURLStrings = [NSMutableArray array];
    dataOneArr = [NSMutableArray array];
    dataTwoArr = [NSMutableArray array];
    dataFourArr = [NSMutableArray array];
    dataThirdArr = [NSMutableArray array];

    [self getData];
    
    // Do any additional setup after loading the view from its nib.
//    imagesURLStrings = @[
//                         @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                         @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                         @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];

    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
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
    [self getData];

    [self showIndicatorView];
}
//上拉加载
-(void)addFooter
{
    [self getData];
    [self showIndicatorView];
}
-(void)getData
{
    [[HttpHelper sharedInstance] shopDailGetdatashopperId:self.shopperId];
}
-(void)creatView
{
    self.navigationItem.title =@"店铺详情";

    [self addBackBtnWithImageNormal:@"back"
                            fuction:@selector(localMap)];
    //消息
    
    [self addNextBtnWithImageNormal:@"xiaoxi1"
                            fuction:@selector(xiaoxi)];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        DetailOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailOneTableViewCell"];
        if (!cell ) {
            cell   = [[[NSBundle mainBundle] loadNibNamed:@"DetailOneTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;
        }
        cell.scrollImg.delegate = self;
        cell.scrollImg.imageURLStringsGroup = imagesURLStrings;
        [cell.mBtn addTarget:self action:@selector(payBtn) forControlEvents:UIControlEventTouchUpInside];
        [cell.fenx addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
        if (dataOneArr.count > 0) {
            ShopsDailtModel *mod = dataOneArr[0];
            cell.fen.text = [NSString stringWithFormat:@"%@分",mod.starLevel];
            cell.name.text = mod.shopperName;
            [cell.Rating displayRating:[mod.starLevel integerValue]];
        }
    
        return cell;
    }
    if (indexPath.row == 1) {
        LocallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocallTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LocallTableViewCell" owner:self options:nil] lastObject];
            cell.selectionStyle = UITableViewCellAccessoryNone;

            
        }
        [cell.payBtn addTarget:self action:@selector(payBtn) forControlEvents:UIControlEventTouchUpInside];
        if (dataOneArr.count > 0) {
            ShopsDailtModel *mod = dataOneArr[0];
            cell.mapLab.text = mod.shopperAddress;
            cell.tellLab.text = mod.fixedphone;
            [cell.mapBtn addTarget:self action:@selector(mapBtn) forControlEvents:UIControlEventTouchUpInside];

        }
        
        return cell;
        
    }
    if (indexPath.row == 2) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, SCREEN_WIDTH / 2, 30);
            [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
            [btn setTitle:@"特价商品" forState:UIControlStateNormal];
            btn.tag = 1;
            [btn addTarget:self action:@selector(oneBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            btn1.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2, 30);
            [btn1 setTitleColor:UIBLACK forState:UIControlStateNormal];
            [btn1 setTitle:@"兑换商品" forState:UIControlStateNormal];
            btn1.tag = 2;
            [btn1 addTarget:self action:@selector(oneBtn:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn1];
            /////////////////////////////////////////////
//            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn2.frame = CGRectMake(0, 0, SCREEN_WIDTH / 4, 30);
//            [btn2 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn2 setTitle:@"默认" forState:UIControlStateNormal];
//            btn2.tag = 4;
//            [btn2 addTarget:self action:@selector(twoBtn:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:btn2];
//            
//            UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn3.frame = CGRectMake(SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 4, 30);
//            [btn3 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn3 setTitle:@"销量" forState:UIControlStateNormal];
//            btn3.tag = 5;
//            [btn3 addTarget:self action:@selector(twoBtn:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:btn3];
//            
//            UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn4.frame = CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 4, 30);
//            [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn4 setTitle:@"价格" forState:UIControlStateNormal];
//            btn4.tag = 6;
//            [btn4 addTarget:self action:@selector(twoBtn:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:btn4];
//            
//            UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn5.frame = CGRectMake(SCREEN_WIDTH / 2 +SCREEN_WIDTH / 4, 0, SCREEN_WIDTH / 4, 30);
//            [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn5 setTitle:@"最新" forState:UIControlStateNormal];
//            btn5.tag = 7;
//            [btn5 addTarget:self action:@selector(twoBtn:) forControlEvents:UIControlEventTouchUpInside];
//            [cell addSubview:btn5];
            
            [btn.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
            [btn.layer setBorderWidth:1];
            [btn.layer setMasksToBounds:YES];
            [btn1.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
            [btn1.layer setBorderWidth:1];
            [btn1.layer setMasksToBounds:YES];
            
//            [btn2.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
//            [btn2.layer setBorderWidth:1];
//            [btn2.layer setMasksToBounds:YES];
//            [btn3.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
//            [btn3.layer setBorderWidth:1];
//            [btn3.layer setMasksToBounds:YES];
//            [btn4.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
//            [btn4.layer setBorderWidth:1];
//            [btn4.layer setMasksToBounds:YES];
//            [btn5.layer setBorderColor:UICOLOR_HEX(0x969fa8).CGColor];
//            [btn5.layer setBorderWidth:1];
//            [btn5.layer setMasksToBounds:YES];
        }
        UIButton *btn = (UIButton *)[cell viewWithTag:1];
        UIButton *btn2 = (UIButton *)[cell viewWithTag:2];
        
//        UIButton *btn4 = (UIButton *)[cell viewWithTag:4];
//        UIButton *btn5 = (UIButton *)[cell viewWithTag:5];
//        UIButton *btn6 = (UIButton *)[cell viewWithTag:6];
//        UIButton *btn7 = (UIButton *)[cell viewWithTag:7];

        if (a == 1) {
            [btn setTitleColor:UIRED forState:UIControlStateNormal];
            [btn2 setTitleColor:UIBLACK forState:UIControlStateNormal];

        }if (a == 2) {
            [btn setTitleColor:UIBLACK forState:UIControlStateNormal];
            [btn2 setTitleColor:UIRED forState:UIControlStateNormal];
        }
//        if (b == 1) {
//            [btn4 setTitleColor:UIRED forState:UIControlStateNormal];
//            [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn6 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn7 setTitleColor:UIBLACK forState:UIControlStateNormal];
//        }
//        if (b == 2) {
//            [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn5 setTitleColor:UIRED forState:UIControlStateNormal];
//            [btn6 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn7 setTitleColor:UIBLACK forState:UIControlStateNormal];
//        }
//        if (b == 3) {
//            [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn6 setTitleColor:UIRED forState:UIControlStateNormal];
//            [btn7 setTitleColor:UIBLACK forState:UIControlStateNormal];
//        }
//        if (b == 4) {
//            [btn4 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn5 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn6 setTitleColor:UIBLACK forState:UIControlStateNormal];
//            [btn7 setTitleColor:UIRED forState:UIControlStateNormal];
//        }

        return cell;
    }
    if (indexPath.row == 3) {
        UIButton *button;
        
        //行间距
        
        int rowLength = 5;
        
        //列间距
        int columnLength = 1;
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell"];
        if (!cell || dataThirdArr.count > 0 || dataFourArr.count >0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"thirdCell"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            if (a == 2) {
                
                UILabel *lab3 = (UILabel *)[cell viewWithTag:202];
                UILabel *lab5 = (UILabel *)[cell viewWithTag:303];
                [lab3 removeFromSuperview];
                [lab5 removeFromSuperview];
                
                
                
                for (int n = 0; n < dataThirdArr.count; n ++) {
                    ExChangeModel *mod = dataThirdArr[n];
                    
                    int x = (n %2)*((SCREEN_WIDTH - 1)/2 + columnLength) + columnLength;
                    
                    int y = (n/2)*((SCREEN_WIDTH - 1)/2 +50 + rowLength) + rowLength;
                    //                    NSLog(@"X:%d y:%d",x,y);
                    button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 1)/2 - 1, (SCREEN_WIDTH - 1)/2 + 50);
                    button.tag = n;
                    [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
                    //                [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:n]] forState:UIControlStateNormal];
                    [cell addSubview:button];
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height - 40)];
                    [img sd_setImageWithURL:[NSURL URLWithString:mod.mainImage]];
                    [button addSubview:img];
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 40, button.frame.size.width, 20)];
                    lab.tag = 101;
                    lab.text = mod.productname;
                    lab.font = [UIFont systemFontOfSize:14];
                    lab.textColor = UIBLACK;
                    lab.textAlignment = NSTextAlignmentLeft;
                    [button addSubview:lab];
                    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 20, button.frame.size.width -6, 20)];
                    lab1.text = [NSString stringWithFormat:@"%@龙点币",mod.coinnum];
                    lab1.tag = 99;
                    lab1.font = [UIFont systemFontOfSize:14];
                    lab1.textColor = UIBLACK;
                    lab1.textAlignment = NSTextAlignmentRight;
                    [button addSubview:lab1];
                    
                }
            }
            
            if (a == 1)
            {
                UILabel *lab = (UILabel *)[cell viewWithTag:101];
                UILabel *lab1 = (UILabel *)[cell viewWithTag:99];
                [lab removeFromSuperview];
                [lab1 removeFromSuperview];
                for (int n = 0; n < dataFourArr.count; n ++) {
                    SpecialPriceModel *mod = dataFourArr[n];
                    
                    int x = (n %2)*((SCREEN_WIDTH - 1)/2 + columnLength) + columnLength;
                    
                    int y = (n/2)*((SCREEN_WIDTH - 1)/2 +50 + rowLength) + rowLength;
                    //                    NSLog(@"X:%d y:%d",x,y);
                    button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 1)/2 - 1, (SCREEN_WIDTH - 1)/2 + 50);
                    button.tag = n;
                    [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
                    //                [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:n]] forState:UIControlStateNormal];
                    [cell addSubview:button];
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height - 40)];
                    [img sd_setImageWithURL:[NSURL URLWithString:mod.mainImage]];
                    [button addSubview:img];
                    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 40, button.frame.size.width, 20)];
                    lab.tag = 202+ n;
                    lab.text = mod.productname;
                    lab.font = [UIFont systemFontOfSize:14];
                    lab.textColor = UIBLACK;
                    lab.textAlignment = NSTextAlignmentLeft;
                    [button addSubview:lab];
                    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 20, button.frame.size.width -6, 20)];
                    lab.tag = 303 + n;
                    lab1.text = [NSString stringWithFormat:@"%@元",mod.coinnum];
                    
                    lab1.font = [UIFont systemFontOfSize:14];
                    lab1.textColor = UIBLACK;
                    lab1.textAlignment = NSTextAlignmentRight;
                    [button addSubview:lab1];
                    
                }
            }

        }
    
        
        return cell;
        

    }

    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return SCREEN_WIDTH/3 *2 + 100;
            
        }
        if (indexPath.row == 1)
        {
            return 86;
            
        }
        else if (indexPath.row == 2)
        {
            return 30;
        }
        else if (indexPath.row == 3)
        {
            if (SCREEN_WIDTH > 320) {
                if (a == 1) {
                    return dataFourArr.count * (SCREEN_WIDTH - 60)/1.5 +100;
                    
                }
                return dataThirdArr.count * (SCREEN_WIDTH - 60)/1.5 + 100;
            }
            else
            {
                if (a == 1) {
                    return dataFourArr.count * (SCREEN_WIDTH - 60)/1.5 + 100;
                    
                }
                return dataThirdArr.count * (SCREEN_WIDTH - 60)/1.5 + 100;
            }

  
        }
    }
    if (indexPath.section == 1) {
        return 20;
    }
    
    return 320;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000000001;
}
-(void)oneBtn:(UIButton *)btn
{
    if (btn.tag == 1) {
        [btn setTitleColor:UIRED forState:UIControlStateNormal];
        a = 1;
    }
    else
    {
        [btn setTitleColor:UIRED forState:UIControlStateNormal];
        a = 2;

    }
    [table reloadData];

}
-(void)twoBtn:(UIButton *)btn
{
    switch (btn.tag) {
        case 4:
            b = 1;
            break;
        case 5:
            b = 2;
            break;
        case 6:
            b = 3;
            break;
        case 7:
            b = 4;
            break;
            
        default:
            break;
    }
    [table reloadData];
}
-(void)shareBtn
{
    [self sharedWithcontArr:@[@"12345645"]];
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];
    [dataOneArr removeAllObjects];
    [dataTwoArr removeAllObjects];
    [dataThirdArr removeAllObjects];
    [dataFourArr removeAllObjects];
    [imagesURLStrings removeAllObjects];
    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([SHOPSDAIL isEqualToString:key] )
    {
        NSDictionary *successDic = [notify userInfo][SHOPSDAIL];
//        NSLog(@"数据%@",successDic);
        ShopsDailtModel *mod1 = [[ShopsDailtModel alloc] init];
        [mod1 setValuesForKeysWithDictionary:successDic];
        [dataOneArr addObject:mod1];
        NSArray *sourceArray = successDic[@"recommendProductList"];
        
        [sourceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             RecommendModel *mod2 =[[RecommendModel alloc]init];
             [mod2 setValuesForKeysWithDictionary:obj];
             NSString *imgurl = obj[@"mainImage"];
             [imagesURLStrings addObject:imgurl];
             [dataTwoArr addObject:mod2];
         }];
        NSArray *sourceArray1 = successDic[@"exchangeProductList"];
        [sourceArray1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ExChangeModel *mod3 = [[ExChangeModel alloc] init];
            [mod3 setValuesForKeysWithDictionary:obj];
            [dataThirdArr addObject:mod3];
        }];
        NSArray *sourceArray2 = successDic[@"specialPriceProductList"];
        [sourceArray2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SpecialPriceModel *mod = [[SpecialPriceModel alloc] init];
            [mod setValuesForKeysWithDictionary:obj];
            [dataFourArr addObject:mod];
        }];


    }
    [table reloadData];
}
- (void)failure:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];
    [self showAlertWithPoint:0 text:[notify userInfo][FAILURE] color:UIPINK];
}
-(void)mapBtn
{
    PhoneGPSViewController *mvc = [[PhoneGPSViewController alloc] init];
    mvc.locaLatitude = locaLatitude;
    mvc.locaLongitude = locaLongitude;
    ShopsDailtModel *mod = dataOneArr[0];
    mvc.purpose = mod.shopperAddress;
    mvc.current = showmeg;
    [self.navigationController pushViewController:mvc animated:YES];
}
-(void)go:(UIButton *)btn
{
    NSString *productid;
    if (a == 1)
    {
        SpecialPriceModel *mod = dataFourArr[btn.tag];
        productid = mod.productid;
        OfflineViewController *ovc = [[OfflineViewController alloc] init];
        ovc.productId = productid;
        ovc.seletedOn = 1;
        [self.navigationController pushViewController:ovc animated:YES];

    }
    if (a == 2)
    {
        ExChangeModel *mod = dataThirdArr[btn.tag];
        productid = mod.productid;
        OfflineViewController *ovc = [[OfflineViewController alloc] init];
        ovc.productId = productid;
        ovc.seletedOn = 2;
        [self.navigationController pushViewController:ovc animated:YES];


    }
//    NSLog(@"%@",productid);
   
}
//消息
-(void)xiaoxi
{
    
}
-(void)localMap
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - SDCycleScrollViewDelegat e

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
-(void)payBtn
{
    if (NULL_STR([USER_DEFAULT objectForKey:USERID]))
    {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:lvc animated:NO];
    }
    else
    {
        [USER_DEFAULT setObject:@"1" forKey:@"boa"];
        LookViewController *pvc = [[LookViewController alloc] init];
        [self.navigationController pushViewController:pvc animated:YES];
    }
    
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %@,long %f",userLocation,userLocation.location.coordinate.longitude);
    //以下_mapView为BMKMapView对象
    [_locService stopUserLocationService];//取消定位
    locaLatitude = userLocation.location.coordinate.latitude;//纬度
    locaLongitude = userLocation.location.coordinate.longitude;//精度
    BMKCoordinateRegion region;
    //将定位的点居中显示
    region.center.latitude=locaLatitude;
    region.center.longitude=locaLongitude;
    [self onClickReverseGeocode];

}
-(void)onClickReverseGeocode  //发送反编码请求的.
{
    //    isGeoSearch = false;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};//初始化
    if (_locService.userLocation.location.coordinate.longitude!= 0
        && _locService.userLocation.location.coordinate.latitude!= 0) {
        //如果还没有给pt赋值,那就将当前的经纬度赋值给pt
        pt = (CLLocationCoordinate2D){_locService.userLocation.location.coordinate.latitude,
            _locService.userLocation.location.coordinate.longitude};
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];//初始化反编码请求
    reverseGeocodeSearchOption.reverseGeoPoint = pt;//设置反编码的店为pt
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];//发送反编码请求.并返回是否成功
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        
        NSString* titleStr;
        titleStr = @"当前城市切换";//streetName
       // district
        NSLog(@"%@ %@",result.addressDetail.district,result.addressDetail.streetName);
        showmeg = [NSString stringWithFormat:@"%@ %@",result.addressDetail.district,result.addressDetail.streetName];
  
    }
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
