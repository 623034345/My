//
//  EstateViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/12.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//            财产

#import <UIKit/UIKit.h>
#import "CloudMoneyViewController.h"
#import "EstateTableViewCell.h"
#import "CloudBeanViewController.h"
#import "BalanceViewController.h"
#import "DividendViewController.h"
#import "PublicViewController.h"
#import "AdministrationViewController.h"
#import "ModifyViewController.h"
#import "GradeViewController.h"
#import "SilkViewController.h"
#import "DrawalZViewController.h"
@interface EstateViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
}
@end
