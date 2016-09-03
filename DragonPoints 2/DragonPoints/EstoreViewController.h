//
//  EstoreViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/8.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//        商城店铺详情

#import <UIKit/UIKit.h>
#import "DetailOneTableViewCell.h"
#import "LocallTableViewCell.h"
#import "ShopDatailViewController.h"
#import "PhotoViewController.h"
#import "LookViewController.h"
@interface EstoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>
{
    NSMutableArray *imagesURLStrings;
    UITableView *table;
    NSMutableArray *referralArr;
    int a;
    int b;
    
}
@property (nonatomic ,strong)NSMutableArray *photosImg;
@end
