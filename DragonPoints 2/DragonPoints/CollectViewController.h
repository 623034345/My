//
//  CollectViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           收藏店铺

#import <UIKit/UIKit.h>
#import "RatingBar/RatingBarView.h"
#import "CollecTableViewCell.h"
#import "CshopTableViewCell.h"
#define  DIC_EXPANDED @"expanded" //是否是展开 0收缩 1展开
#define  DIC_ARARRY @"array"
#define  DIC_TITILESTRING @"title"
@interface CollectViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,RatingBarDelegate>
{
    UITableView *table;
    NSMutableArray *btnArr;
    BOOL isKai;
    NSMutableArray *_DataArray;
    NSInteger type;

}

@end
