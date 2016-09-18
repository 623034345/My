//
//  AdministrationViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/13.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//             提现账户管理

#import <UIKit/UIKit.h>
#import "ModifyViewController.h"
@interface AdministrationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSDictionary *dataDic;
}
@property(nonatomic) NSInteger onType;
@property(nonatomic) NSString *hasBankCard;
@property(nonatomic) NSString *hasZhifubao;

@end
