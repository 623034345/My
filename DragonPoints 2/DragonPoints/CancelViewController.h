//
//  CancelViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//              订单验证

#import <UIKit/UIKit.h>
#import "SuccessTableViewCell.h"

@interface CancelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSMutableArray *dataArr;
}
@end
