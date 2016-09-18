//
//  SearchViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/1.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//      搜索

#import <UIKit/UIKit.h>
#import "HisModel.h"
#import "ShopsViewController.h"
#import "HomeDetailViewController.h"
#define searchKey @"searchContent"
@interface SearchViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UISearchBar * bar;
    UITableView *table;
    BOOL _isHasEqual;
}
@property(nonatomic,copy)   NSString  *text;
@property(nonatomic,copy)   NSMutableArray *hisArr;

@end
