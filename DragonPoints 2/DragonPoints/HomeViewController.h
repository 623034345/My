//
//  HomeViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollView.h"
#import "HomeDetailViewController.h"
#import "MoreViewController.h"
#import "SDCycleScrollView.h"
#import "CityChooseViewController.h"
#import "SearchViewController.h"
#import "OfflineViewController.h"
#import "HomeModel.h"
#import "FloorModel.h"
#import "FloorNameModel.h"
#import "HomeTopModel.h"
#import "BalancePayViewController.h"
#import "HomeCateModel.h"
#import "DetailedViewController.h"
@interface HomeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,MWPhotoBrowserDelegate>
{
    UITableView *table;
    ScrollView *firstRcmdScrollView;//一级推荐轮播图
    NSMutableArray *scrollerArray;  //轮播图对象数组
    NSMutableArray *firstRcmdTopicArr; //一级推荐数组
    NSMutableArray *TopicArr;

    NSMutableArray *HdArr; //一级推荐数组
    
    NSMutableArray *fArr0; //一级推荐数组
    NSMutableArray *fArr1; //一级推荐数组
    NSMutableArray *fArr2; //一级推荐数组
    NSMutableArray *fArr3; //一级推荐数组
    NSMutableArray *fArr4; //一级推荐数组
    NSMutableArray *fArr5; //一级推荐数组

    NSMutableArray *shiyanArr; //一级推荐数组

    
    NSMutableArray *imagesURLStrings;
    BMKLocationService *_locService ;
    BMKGeoCodeSearch *_geocodesearch;
    long locaLatitude;
    long locaLongitude;
    UIButton *backBtn;
    NSInteger cellHeight;
    NSString *cityName;
    NSString* showmeg;

}
@property (nonatomic ,strong)NSMutableArray *photosImg;

@end
