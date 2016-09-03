//
//  RefundViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/16.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//        退款

#import <UIKit/UIKit.h>
#import "SingleTickTableViewCell.h"
@interface RefundViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    //该数组负责记录索引
    NSMutableArray *_selectedArr;
    
    NSMutableArray *shopArr;
    NSMutableArray *referralArr;
    NSMutableArray *loca;
}
@end
