//
//  MapViewController.m
//  DragonPoints
//
//  Created by shangce on 16/8/5.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@end

@implementation MapViewController
-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [_mapView setMapType:BMKMapTypeStandard];

    //打开实时路况图层
    [_mapView setTrafficEnabled:YES];
    
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    [self setMapViewProperty];
    self.view = _mapView;
    //初始化BMKLocationService
    //启动LocationService
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    //编码服务的初始化(就是获取经纬度,或者获取地理位置服务)
    _geocodesearch.delegate = self;//设置代理为self



}
#pragma mark - 设置mapView属性
-(void)setMapViewProperty
{
//    mapView.mapType = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES; //是否显示定位图层（即我的位置的小圆点）
    _mapView.zoomLevel = 16;//地图显示比例
    _mapView.rotateEnabled = NO; //设置是否可以旋转
    
  
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %@,long %f",userLocation,userLocation.location.coordinate.longitude);
    //以下_mapView为BMKMapView对象
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView updateLocationData:userLocation];
    [_locService stopUserLocationService];//取消定位
    locaLatitude = userLocation.location.coordinate.latitude;//纬度
    locaLongitude = userLocation.location.coordinate.longitude;//精度
    BMKCoordinateRegion region;
    //将定位的点居中显示
    region.center.latitude=locaLatitude;
    region.center.longitude=locaLongitude;
//    [_mapView setCenterCoordinate:userLocation animated:YES];
    _mapView.centerCoordinate = userLocation.location.coordinate;
}
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//开始定位
-(void)mapViewWillStartLocatingUser:(BMKMapView *)mapView{
    NSLog(@"开始定位");
    mapView.showsUserLocation = YES;//显示定位图层
    [_locService stopUserLocationService];//取消定位

    BMKCoordinateRegion region;
    //将定位的点居中显示
    region.center.latitude=locaLatitude;
    region.center.longitude=locaLongitude;
}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */

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
