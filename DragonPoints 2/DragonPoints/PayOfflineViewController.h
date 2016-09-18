//
//  PayOfflineViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/3.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//  详细地址 线上买单  提交订单

#import <UIKit/UIKit.h>
#import "FrameOnTableViewCell.h"
#import "PayViewController.h"
@interface PayOfflineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *table;
    UILabel *numLab;
    int a;
    UITextField *fieldYan;

}
@end
