//
//  DetaillEViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/4.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//        商城店铺列表

#import <UIKit/UIKit.h>
#import "EdetailTableViewCell.h"
#import "ShopDatailViewController.h"

@interface DetaillEViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    long seleted;
}
@end
