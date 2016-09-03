//
//  CloudBeanViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//       我得云豆

#import <UIKit/UIKit.h>
#import "WithdrawViewController.h"
#import "MyBeanModel.h"
#import "ModifyViewController.h"
#import "DrawalZViewController.h"
@interface CloudBeanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSInteger seletedIndex;
    UITextField *textField;
    UITextField *textField1;
    NSDictionary *data;
    NSMutableArray *dataArr;
}
@end
