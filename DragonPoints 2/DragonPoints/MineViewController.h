//
//  MineViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//              我的

#import <UIKit/UIKit.h>
#import "AllOrderViewController.h"
#import "JudgeViewController.h"
#import "SettledLoginViewController.h"
#import "CollectViewController.h"
#import "MineSettingViewController.h"
#import "FootMarkViewController.h"
#import "PaySuccessViewController.h"
#import "EstateViewController.h"
#import "AllShareViewController.h"
#import "LoginViewController.h"
#import "SettledShopViewController.h"
#import "MyShopViewController.h"
#import "OperationsCenterViewController.h"
@interface MineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *mineTable;
    NSDictionary *dataDic;
}
@end
