//
//  PreSaleViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           预售

#import <UIKit/UIKit.h>
#import "SuccessTableViewCell.h"
#import "PayViewController.h"
#import "DetailedViewController.h"
#import "PreSaleModel.h"
#import "BalancePayViewController.h"
@interface PreSaleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *table;
    UILabel *numLab;
    int a;
    UITextField *fieldYan;
    NSString *price;
    NSMutableArray *dataArr;
    NSDictionary *data;
}
@property(nonatomic)NSInteger onType;
@property(nonatomic,copy)NSString *priceStr;
@property(nonatomic,copy)NSString *productId;
@end
