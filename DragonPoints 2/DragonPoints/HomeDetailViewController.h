//
//  HomeDetailViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//            全部商家

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "DropDownListView.h"
#import "JSDropDownMenu.h"
#import "MoreOneModel.h"
#import "MoreTwoModel.h"
#import "ShopsModel.h"
#import "MoreTwoModel.h"
#import "MoreOneModel.h"
#import "DistrictModel.h"
#import "townListModel.h"
#import "ShopListModel.h"
#import "DetailedViewController.h"
@interface HomeDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,JSDropDownMenuDataSource,JSDropDownMenuDelegate>
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
@property (nonatomic, copy)NSString *cid;
@property (nonatomic , copy)NSString *className;
@end
