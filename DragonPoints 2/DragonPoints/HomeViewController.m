//
//  HomeViewController.m
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if (view.tag == 66|| view.tag == 22) {
            [view setHidden:NO];
        }
    }
    //显示NavigationBar
    [self.navigationController.navigationBar setHidden:NO];

    //隐藏tabBar
    [self.tabBarController.tabBar setHidden:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //添加观察者
    [[HttpHelper sharedInstance] addListener:self
                                     success:@selector(success:)
                                     failure:@selector(failure:)];
    //初始化BMKLocationService
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
//    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
//    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
//    _geocodesearch.delegate = self;//设置代理为self

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if (view.tag == 66 || view.tag == 22) {
            [view setHidden:YES];
        }
    }
    //移除观察者
    [[HttpHelper sharedInstance] removeListener:self];
    _geocodesearch.delegate=nil;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    ViewController BasedStatusBarAppearance = YES;
    TopicArr = [NSMutableArray array];
    scrollerArray = [NSMutableArray array];
    firstRcmdTopicArr = [NSMutableArray array];
    fArr0 = [NSMutableArray array];
    fArr1 = [NSMutableArray array];
    fArr2 = [NSMutableArray array];
    fArr3 = [NSMutableArray array];
    fArr4 = [NSMutableArray array];
    fArr5 = [NSMutableArray array];
    cityName = @"郑州市";

    shiyanArr = [NSMutableArray array];
    HdArr = [NSMutableArray arrayWithCapacity:0];
    [USER_DEFAULT setObject:[NSString stringWithFormat:@"%f",121.55] forKey:@"lat"];
    [USER_DEFAULT setObject:[NSString stringWithFormat:@"%f",31.55] forKey:@"lng"];
    [self getData];
    [self showIndicatorView];

    
    
    imagesURLStrings = [NSMutableArray new];
    self.view.backgroundColor = UIGRAY;
    
    //UIBarButtonLeftItem
    backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 30);
    [backBtn setTitle:cityName forState:UIControlStateNormal];
    backBtn.titleEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
    [backBtn setTitleColor:UIBLACK forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize: 13];
    backBtn.tag = 22;
    [backBtn addTarget:self
                action:@selector(localMap:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:backBtn];
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weizhi"]];
    img.frame = CGRectMake(50, 10, 15, 10);
    [backBtn addSubview:img];
    
    //搜索
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(70, 0, SCREEN_WIDTH - 130, 30);
    btn.tag = 66;
    btn.backgroundColor = UIWHITE;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 10;
    self.navigationController.navigationBar.tag = 101;
    [btn addTarget:self action:@selector(searchBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:btn];
    
    UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo"]];
    img1.frame = CGRectMake(10, 5, 20, 20);
    [btn addSubview:img1];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(SCREEN_WIDTH  - 160, 2.5, 25, 25);
    btn1.userInteractionEnabled = YES;
    [btn1 setBackgroundImage:[UIImage imageNamed:@"sao"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(sao) forControlEvents:UIControlEventTouchUpInside];
    [btn addSubview:btn1];
    

    [self addNextBtnWithImageNormal:@"xiaoxi1" fuction:@selector(xiaoxi)];
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 113) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [table addHeaderWithTarget:self action:@selector(addHeader)];
    [table addFooterWithTarget:self action:@selector(addFooter)];

    [self.view addSubview:table];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _geocodesearch.delegate = self;//设置代理为self


}
-(void)sao
{
    if ([[GlobalCenter sharedInstance] isCameraAvailable])
    {
        // authorized
        ScanQRcode *vc = [[ScanQRcode alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        [self showAlertWithPoint:1 text:@"未获取访问相机权限" color:UIPINK];
    }


}
#pragma mark- ImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //1.获取选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //2.初始化一个监测器
    CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    [picker dismissViewControllerAnimated:YES completion:^{
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >=1) {
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            NSString *scannedResult = feature.messageString;
            if (scannedResult) {
                NSString *contents = scannedResult;
                if ([contents containsString:@"http://"]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:contents]];
                }else{
                    NSLog(@"扫描结果：%@",contents);
                }
            }
        }
        else{
            NSLog(@"该图片没有包含一个二维码！");
        }
    }];
}
-(void)getData
{
    [[HttpHelper sharedInstance] homeGetdataWithCity:UTF_8(cityName)];

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
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位%@", error);
    //Error Domain=kCLErrorDomain Code=0 "The operation couldn’t be completed. (kCLErrorDomain error 0.)"
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"当前位置%f,%f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
//    [_mapView updateLocationData:userLocation];
//    _mapView.centerCoordinate = userLocation.location.coordinate;
    [_locService stopUserLocationService];//取消定位
    locaLatitude=userLocation.location.coordinate.latitude;//纬度
    locaLongitude=userLocation.location.coordinate.longitude;//精度
    [USER_DEFAULT setObject:[NSString stringWithFormat:@"%ld",locaLatitude] forKey:@"lat"];
    [USER_DEFAULT setObject:[NSString stringWithFormat:@"%ld",locaLongitude] forKey:@"lng"];
    
    BMKCoordinateRegion region;
    //将定位的点居中显示
    region.center.latitude=locaLatitude;
    region.center.longitude=locaLongitude;
    
    //反地理编码出地理位置
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    pt=(CLLocationCoordinate2D){locaLatitude,locaLongitude};
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
        titleStr = @"是否切换为当前城市";
        NSLog(@"%@",result.addressDetail.city);
        showmeg = [NSString stringWithFormat:@"%@",result.addressDetail.city];
        if (![showmeg isEqualToString:cityName])
        {
            UIAlertAction *alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self determine];
                
            }];
            [self alertControllerQue:alert prompt:titleStr msg:showmeg];


        }
//            strProvince=result.addressComponent.province;//省份
//            strCity=result.addressComponent.city;//城市
//            strDistrict=result.addressComponent.district;//地区
        //		CLGeocoder *geocoder=[[CLGeocoder alloc] init];
        //		CLGeocodeCompletionHandler handle=^(NSArray *palce,NSError *error){
        //			for (CLPlacemark *placemark in palce) {
        //				NSLog(@"%@1-%@2-%@3-%@4-%@5-%@6-%@7-%@8-%@9-%@10-%@11-%@12",placemark.name,placemark.thoroughfare,placemark.subThoroughfare,placemark.locality,placemark.subLocality,placemark.administrativeArea,placemark.postalCode,placemark.ISOcountryCode,placemark.country,placemark.inlandWater,placemark.ocean,placemark.areasOfInterest);
        //				break;
        //			}
        //		};
        //		CLLocation *loc = [[CLLocation alloc] initWithLatitude:locaLatitude longitude:locaLongitude];
        //		[geocoder reverseGeocodeLocation:loc completionHandler:handle];

    }
}
-(void)determine
{
    cityName = showmeg;
    [backBtn setTitle:cityName forState:UIControlStateNormal];
    [self getData];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;

    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return scrollerArray.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                SDCycleScrollView *cycleScrollView3 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3 *2) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
                cycleScrollView3.currentPageDotImage = [UIImage imageNamed:@"pageControlCurrentDot"];
                cycleScrollView3.pageDotImage = [UIImage imageNamed:@"pageControlDot"];
                cycleScrollView3.tag = 23;
                [cell addSubview:cycleScrollView3];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                
            }
            SDCycleScrollView *cycleScrollView3 = (SDCycleScrollView *)[cell viewWithTag:23];
            cycleScrollView3.imageURLStringsGroup = imagesURLStrings;

            
  
            return cell;

        }
        if (indexPath.row == 1) {
            UIButton *button;

            //行间距
            
            int rowLength = 30;
            
            //列间距
            int columnLength = 0;
//            NSArray *imgArr =@[@"zhushi",@"snack",@"KTV",@"lavipeditum",@"qbfl"];
//            NSArray *labArr =@[@"主食",@"快餐",@"KTV",@"足浴",@"全部"];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellOne"];
            if (!cell || fArr0.count > 0) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellOne"];
                
                for (int n = 0; n < fArr0.count; n ++) {
                    HomeCateModel *mod = fArr0[n];
                    int x = (n %5)*((SCREEN_WIDTH)/5 + columnLength) + columnLength;
                    
                    int y = (n/5)*((SCREEN_WIDTH)/5 + rowLength) + rowLength - 25;
                    //                    NSLog(@"X:%d y:%d",x,y);
                    button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(x, y, (SCREEN_WIDTH)/5, (SCREEN_WIDTH)/5);
                    button.tag = n + 1;
                    [button addTarget:self action:@selector(goOne:) forControlEvents:UIControlEventTouchUpInside];
//                    [button setImage:[UIImage imageNamed:@"shiyan"] forState:UIControlStateNormal];
                    [cell addSubview:button];
                    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, (SCREEN_WIDTH)/5, (SCREEN_WIDTH)/5)];
                    [img sd_setImageWithURL:[NSURL URLWithString:mod.categoryimage]];
                    [cell addSubview:img];
                    UILabel *lab = [[UILabel alloc] init];
                    lab.frame = CGRectMake(x, y +(SCREEN_WIDTH)/5, (SCREEN_WIDTH)/5, 30);

//                    if (SCREEN_WIDTH >320) {
//                    }
//                    else
//                    {
//                           lab.frame = CGRectMake(button.frame.origin.x, y +(SCREEN_WIDTH)/5 -10, button.frame.size.width, 10);
//                    }
                    lab.text = [NSString stringWithFormat:@"%@",mod.cname];
                    lab.font = [UIFont systemFontOfSize:14];
//                    lab.textColor = UICOLOR_HEX(0xa71520);
                    lab.textAlignment = NSTextAlignmentCenter;
                    [cell addSubview:lab];
                    
                }
//                int x = (4 %5)*((SCREEN_WIDTH - 5)/5 + columnLength) + columnLength;
//                
//                int y = (4/5)*((SCREEN_WIDTH - 5)/5 - 30 + rowLength) + rowLength;
//                //                    NSLog(@"X:%d y:%d",x,y);
//                button = [UIButton buttonWithType:UIButtonTypeCustom];
//                button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 5)/5 - 1, (SCREEN_WIDTH - 5)/5 - 5);
//                button.tag = 5;
//                [button addTarget:self action:@selector(goOne:) forControlEvents:UIControlEventTouchUpInside];
//                [cell addSubview:button];
//                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.size.width / 5, button.frame.size.width / 5 - 10, button.frame.size.width / 2, button.frame.size.width / 2)];
//                img.image = [UIImage imageNamed:@"qbfl"];
//                [button addSubview:img];
//                UILabel *lab = [[UILabel alloc] init];
//                if (SCREEN_WIDTH >320) {
//                    lab.frame = CGRectMake(button.frame.origin.x - 4, button.frame.size.height - 30, button.frame.size.width, 30);
//                }
//                else
//                {
//                    lab.frame = CGRectMake(button.frame.origin.x - 4, button.frame.size.height - 10, button.frame.size.width, 10);
//                }
//                lab.text = [NSString stringWithFormat:@"%@",@"全部"];
//                lab.font = [UIFont systemFontOfSize:14];
//                lab.textColor = UICOLOR_HEX(0xa71520);
//                lab.textAlignment = NSTextAlignmentCenter;
//                [cell addSubview:lab];
                
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            return cell;
            
        }
    }
    if (indexPath.section == 1) {
        UIButton *button;
        
        //行间距
        
        int rowLength = 5;
        
        //列间距
        int columnLength = 1;

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thirdCell"];
        if (!cell || TopicArr.count > 0) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"thirdCell"];
            cell.selectionStyle = UITableViewCellAccessoryNone;
            for (int n = 0; n < TopicArr.count; n ++) {
                HomeModel *mod = TopicArr[n];
                int x = (n %2)*((SCREEN_WIDTH - 1)/2 + columnLength) + columnLength;
                
                int y = (n/2)*((SCREEN_WIDTH - 1)/2 +50 + rowLength) + rowLength;
                button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = n;
                button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 1)/2 - 1, (SCREEN_WIDTH - 1)/2 + 50);
                [button addTarget:self action:@selector(goTwo:) forControlEvents:UIControlEventTouchUpInside];
                //                [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:n]] forState:UIControlStateNormal];
                [cell addSubview:button];
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height - 40)];
                [img sd_setImageWithURL:[NSURL URLWithString:mod.mainImage]];
                [button addSubview:img];
                UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 40, button.frame.size.width, 20)];
                lab.text = mod.productname;
                lab.font = [UIFont systemFontOfSize:14];
                lab.textColor = UIBLACK;
                lab.textAlignment = NSTextAlignmentLeft;
                [button addSubview:lab];
                UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 20, button.frame.size.width -6, 20)];
                if ([mod.isExchange isEqualToString:@"N"]) {
                    lab1.text = [NSString stringWithFormat:@"￥%@ 赠龙点币%@",mod.productprice,mod.coinnum];

                }
                else
                {
                    lab1.text = [NSString stringWithFormat:@"%@龙点币",mod.productprice];//,mod.coinnum

                }
                lab1.font = [UIFont systemFontOfSize:14];
                lab1.textColor = UIBLACK;
                lab1.textAlignment = NSTextAlignmentRight;
                [button addSubview:lab1];
                
            }
        }
 

        return cell;
        
    }
    if (indexPath.section == 2) {
//        NSArray *arr = HdArr[indexPath.row];
        NSString *name = [NSString stringWithFormat:@"loucengCellOne%ld",(long)indexPath.row];
        UIButton *button;
        //行间距
        
        int rowLength = 2;
        
        //列间距
        int columnLength = 1;
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:name];
            cell.selectionStyle = UITableViewCellAccessoryNone;
       
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 45, 5, 80, 30)];
            lab.center = CGPointMake(SCREEN_WIDTH / 2 +10, 20);
            lab.tag = 102;
            lab.textColor = UIRED;
            [cell addSubview:lab];
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(lab.frame.origin.x - 40, 5, 30, 30)];
            img.tag = 103;
            [cell addSubview:img];
            UILabel *lab2 = [[UILabel alloc] init];
            lab2.text = @"本地区暂时没有该类商家";
            lab2.textColor = UIRED;
            lab2.tag = 852;
            [cell addSubview:lab2];
        }
       
        UILabel *lab = (UILabel *)[cell viewWithTag:102];
        UIImageView *img = (UIImageView *)[cell viewWithTag:103];
        FloorNameModel *fMod = scrollerArray[indexPath.row];
        [img sd_setImageWithURL:[NSURL URLWithString:fMod.categoryimage]];
        lab.text = fMod.largecname;
//        NSLog(@"数组的个数%lu",(unsigned long)firstRcmdTopicArr.count);
        if (fMod.productOfflineList.count > 0) {
            for (int n = 0; n < fMod.productOfflineList.count; n ++) {
                FloorModel *mod = fMod.productOfflineList[n];
                int x = (n %3)*((SCREEN_WIDTH - 1)/3 + columnLength) + columnLength;
                
                int y = (n/3)*((SCREEN_WIDTH - 1)/3 +30 + rowLength) + rowLength + 40;
                button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(x, y, (SCREEN_WIDTH - 1)/3 - 3, (SCREEN_WIDTH - 1)/3 + 30);
                button.tag = n;
                button.titleLabel.text = mod.productid;
                [button.titleLabel setHighlighted:YES];
                [button addTarget:self action:@selector(goThire:) forControlEvents:UIControlEventTouchUpInside];
                //                [button setImage:[UIImage imageNamed:[imgArr objectAtIndex:n]] forState:UIControlStateNormal];
                [cell addSubview:button];
                UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, button.frame.size.width, button.frame.size.height - 30)];
                [img sd_setImageWithURL:[NSURL URLWithString:mod.mainImage]];
                
                [button addSubview:img];
                
                UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(4, button.frame.size.height - 20, button.frame.size.width -6, 20)];
                
                lab1.text = [NSString stringWithFormat:@"￥%@",mod.productprice];
                lab1.font = [UIFont systemFontOfSize:14];
//                lab1.textColor = UIRED;
                lab1.textAlignment = NSTextAlignmentRight;
                [button addSubview:lab1];
                
            }
            cellHeight = SCREEN_WIDTH/3 * 2+80 +50;
        }
        else
        {
            UILabel *lab2 = (UILabel *)[cell viewWithTag:852];
            lab2.frame = CGRectMake(10, 60, SCREEN_WIDTH - 20, 60);
            cellHeight =  150;

        }
        return cell;

        
    }


    
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return SCREEN_WIDTH / 3 * 2;
        }
        if (indexPath.row == 1) {
            return SCREEN_WIDTH/5 * 2 + 70;
        }
        if (indexPath.row == 2) {
            return 90;
        }
    }
    if (indexPath.section == 1) {
        
        return SCREEN_WIDTH + 110;
    }
    if (indexPath.section == 2) {
        return cellHeight;
    }

    return SCREEN_WIDTH/3 * 2 +80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.00001;
    }
    else if (section == 1 )
    {
        return 60;
    }
    //    else if (section == 2)
    //    {
    //        return 50;
    //    }
    return 40;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==1) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        img.image = [UIImage imageNamed:@"shppernew"];
        [view addSubview:img];
        return view;
    }

    return nil;
}
#pragma mark --success---
-(void)success:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];

    NSString *key = [[[notify userInfo] allKeys] firstObject];
    if ([HOME isEqualToString:key] )
    {
        [TopicArr removeAllObjects];
        [scrollerArray removeAllObjects];
        [imagesURLStrings removeAllObjects];
        [firstRcmdTopicArr removeAllObjects];
        [fArr0 removeAllObjects];
        NSDictionary *successDic = [notify userInfo][HOME];
        
        NSLog(@"数据 %@",successDic);
        [USER_DEFAULT setObject:successDic[@"cityId"] forKey:@"regionId"];
        NSArray *categoryArr = successDic[@"categoryOfflineListP1"];
        [categoryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HomeCateModel *hMod = [[HomeCateModel alloc] init];
            [hMod setValuesForKeysWithDictionary:obj];
            [fArr0 addObject:hMod];
        }];
        NSArray *sourceArray = successDic[@"productOfflineListP2"];
        [sourceArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             HomeModel *mod =[[HomeModel alloc]init];
             [mod setValuesForKeysWithDictionary:obj];
             [TopicArr addObject:mod];
         }];
        NSArray *sourceArray1 = successDic[@"cAPOfflineListP3"];
        if (![sourceArray1 isKindOfClass:[NSNull class]]) {
            for (NSDictionary *wdic in sourceArray1)
            {
                FloorNameModel *mod = [[FloorNameModel alloc] init];
                [mod setValuesForKeysWithDictionary:wdic];
                NSArray *huodong  = wdic[@"productOfflineList"];
                NSMutableArray *arr1 = [NSMutableArray array];
                [huodong enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    FloorModel *floor = [[FloorModel alloc] init];
                    [floor setValuesForKeysWithDictionary:obj];
                    [arr1 addObject:floor];
                }];
                mod.productOfflineList = arr1;
                [scrollerArray addObject:mod];
            }
        }
        NSArray *shopperSimpleInfoP0 = successDic[@"shopperSimpleInfoP0"];
        [shopperSimpleInfoP0 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HomeTopModel *mod = [[HomeTopModel alloc] init];
            [mod setValuesForKeysWithDictionary:obj];
            NSString *name = obj[@"shopperImage"];

            [imagesURLStrings addObject:name];
            [firstRcmdTopicArr addObject:mod];

        }];


    }

    [table reloadData];
    
}
- (void)failure:(NSNotification *)notify
{
    [self dismissIndicatorView];
    [table headerEndRefreshing];
    [table footerEndRefreshing];
    [self showAlertWithPoint:1
                        text:[notify userInfo][FAILURE]
                       color:UIPINK];
}

- (void)scrollImageClick:(long)taskTag
{
    
    
}
//推荐
-(void)goOne:(UIButton *)button
{
    if (button.tag == fArr0.count) {
        MoreViewController *more = [[MoreViewController alloc] init];
        [self.navigationController pushViewController:more animated:YES];
    }
    else
    {
        HomeDetailViewController *more = [[HomeDetailViewController alloc] init];
        HomeCateModel *mod = fArr0[button.tag-1];
        more.cid = mod.cid;
        more.className = mod.cname;


        [self.navigationController pushViewController:more animated:YES];

    }

}
////休闲娱乐
//-(void)goFour:(UIButton *)button
//{
//    OfflineViewController *ovc = [[OfflineViewController alloc] init];
//    [self.navigationController pushViewController:ovc animated:YES];
//}
//餐饮
-(void)goThire:(UIButton *)button
{
    OfflineViewController *ovc = [[OfflineViewController alloc] init];
    ovc.productId = button.titleLabel.text;
//    ovc.seletedOn = 1;
    [self.navigationController pushViewController:ovc animated:YES];
    
    NSLog(@"都是什么啊%@",button.titleLabel.text);
}
////新店
-(void)goTwo:(UIButton *)button
{
    HomeModel *mod = TopicArr[button.tag];

    OfflineViewController *ovc = [[OfflineViewController alloc] init];
//    ovc.seletedOn = 1;
    ovc.productId = mod.productid;
    [self.navigationController pushViewController:ovc animated:YES];
    
}
//消息
-(void)xiaoxi
{
    BalancePayViewController *home = [[BalancePayViewController alloc]init];
    [self.navigationController pushViewController:home animated:YES];
}
//选择地址
-(void)localMap:(UIButton *)btn
{
        //城市选择
        CityChooseViewController *vc = [CityChooseViewController new];
        //选择以后的回调
        [vc returnCityInfo:^(NSString *province, NSString *area) {
    //        _province.text = province; //选择的省
    //        _area.text = area; //选择的地区
            cityName = [NSString stringWithFormat:@"%@市",area];
            [btn setTitle:cityName forState:UIControlStateNormal];
            [[HttpHelper sharedInstance] homeGetdataWithCity:UTF_8(cityName)];

        }];
        [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    HomeTopModel *mod = firstRcmdTopicArr[index];
    NSLog(@"点击的 %@",mod.shopperId);
    DetailedViewController *ovc = [[DetailedViewController alloc] init];
    ovc.shopperId = mod.shopperId;
    //    ovc.seletedOn = 1;
    [self.navigationController pushViewController:ovc animated:YES];
//    NSMutableArray *photos = [NSMutableArray array];
//    
//    for (int i=0; i<imagesURLStrings.count; i ++) {
//        [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[imagesURLStrings objectAtIndex:i]]]];
//    }
//    self.photosImg = photos;
//    //创建MWPhotoBrowser ，要使用initWithDelegate方法，要遵循MWPhotoBrowserDelegate协议
//    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
//    
//    //设置当前要显示的图片
//    [browser setCurrentPhotoIndex:0];
//    
//    //push到MWPhotoBrowser
//    [self.navigationController pushViewController:browser animated:YES];
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
-(void)searchBtn
{
    SearchViewController *svc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
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
