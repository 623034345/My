//
//  OfflineViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/1.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//                      线下商品详情

#import <UIKit/UIKit.h>
#import "ShopDtailTableViewCell.h"
#import "PartakeTableViewCell.h"
#import "ImageTTableViewCell.h"
#import "DetailOneTableViewCell.h"
#import "LocallTableViewCell.h"
#import "TellTableViewCell.h"
#import "EvaluateViewController.h"
#import "PayViewController.h"
#import "MapViewController.h"
#import "SpecificationViewController.h"
#import "PreSaleViewController.h"
#import "LastCommentModel.h"
#import "ProductCommonModel.h"
#import "PhoneGPSViewController.h"
@interface OfflineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate,MWPhotoBrowserDelegate>
{
    NSMutableArray *imagesURLStrings;
    NSMutableArray *bottomimagesURLStrings;

    UITableView *table;
    UIScrollView *scrollView;
    NSDictionary *dataDic;
    NSMutableArray *lastDataArr;
    NSMutableArray *productCommonArr;
    
    
   
    float locaLatitude;
    float locaLongitude;
    NSString* showmeg;



}
@property (nonatomic, copy) NSString *productId;
@property (nonatomic,strong) NSMutableArray *postersArr;
@property (nonatomic) NSInteger seletedOn;
@property (nonatomic ,strong)NSMutableArray *photosImg;

@end
