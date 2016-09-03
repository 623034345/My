//
//  CloudMoneyViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//         我的云币

#import <UIKit/UIKit.h>
#import "MyCoinModel.h"
@interface CloudMoneyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSInteger seletedIndex;
    NSMutableArray *dataArr;
    NSDictionary *data;
}
@end
