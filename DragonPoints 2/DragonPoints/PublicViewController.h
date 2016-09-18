//
//  PublicViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//                 公益互助基金

#import <UIKit/UIKit.h>
#import "HelpViewController.h"
#import "MutualModel.h"
@interface PublicViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSMutableArray *dataArr;
    NSDictionary *dataDic;
}
@end
