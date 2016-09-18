//
//  ShopDatailViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/30.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//            线上商品详情

#import <UIKit/UIKit.h>
#import "ShopDtailTableViewCell.h"
#import "PartakeTableViewCell.h"
#import "ImageTTableViewCell.h"
#import "PhotoViewController.h"
#import "EvaluateViewController.h"
#import "PayOfflineViewController.h"
@interface ShopDatailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate>
{
    UITableView *table;
    NSMutableArray *imagesURLStrings;
    
}
@property (nonatomic ,strong)NSMutableArray *photosImg;

@end
