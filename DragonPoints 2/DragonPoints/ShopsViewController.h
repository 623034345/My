//
//  ShopsViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//          商品列表


#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "ShopDatailViewController.h"
#import "DetailedViewController.h"
#import "CityChooseViewController.h"
#import "SearchViewController.h"
#import "DropDownListView.h"
#import "JSDropDownMenu.h"
#import "ShopsModel.h"
#import "MoreTwoModel.h"
#import "MoreOneModel.h"
#import "DistrictModel.h"
#import "townListModel.h"
#import "ShopListModel.h"
@interface ShopsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,JSDropDownMenuDataSource,JSDropDownMenuDelegate>
{
    UITableView *table;
    NSMutableArray *listArr;
    NSMutableArray *moreArr;
    NSMutableArray *oneArr;
    NSMutableArray *areas;
    NSArray *sorts;
    NSMutableArray *ondataArr;
    
    JSDropDownMenu *menu;
    NSInteger _currentData1Index;
    NSInteger _currentData2Index;
    NSInteger _currentData3Index;
    NSInteger _currentData1SelectedIndex;
    NSInteger _currentData1Index2;
    NSInteger _currentData2Index2;
    
    NSString *name1;
    NSString *name2;
    NSString *name3;
    NSMutableArray *dataArr;
    
    NSMutableArray *shopsArr;
    
    NSString *orderType;//排序编号
    NSString *smallCategoryId;//选择类

}
@end
