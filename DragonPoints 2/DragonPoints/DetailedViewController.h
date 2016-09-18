//
//  DetailedViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//   店铺详情

#import <UIKit/UIKit.h>
#import "DetailOneTableViewCell.h"
#import "LocallTableViewCell.h"
#import "OfflineViewController.h"
#import "PhotoViewController.h"
#import "LookViewController.h"
#import "ShopsDailtModel.h"
#import "ExChangeModel.h"
#import "RecommendModel.h"
#import "SpecialPriceModel.h"
#import "MapViewController.h"
#import "PhoneGPSViewController.h"
@interface DetailedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    NSMutableArray *imagesURLStrings;
    UITableView *table;
    NSMutableArray *referralArr;
    int a;
    int b;
    NSMutableArray *dataOneArr;
    NSMutableArray *dataTwoArr;
    NSMutableArray *dataThirdArr;
    NSMutableArray *dataFourArr;
    BMKPoiSearch *_search;
    BMKLocationService *_locService ;
    BMKGeoCodeSearch *_geocodesearch;
    float locaLatitude;
    float locaLongitude;
    NSString* showmeg;


}
@property (nonatomic ,strong)NSMutableArray *photosImg;
@property (nonatomic, copy) NSString *shopperId;
@end
