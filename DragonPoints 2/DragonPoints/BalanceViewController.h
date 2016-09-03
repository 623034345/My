//
//  BalanceViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//            我的余额

#import <UIKit/UIKit.h>
#import "MyBalanceModel.h"
@interface BalanceViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSInteger seletedIndex;
    UITextField *textField;
    NSDictionary *dataDic;
    NSMutableArray *dataArr;
}
@end
