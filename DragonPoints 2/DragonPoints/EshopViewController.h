//
//  EshopViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//          商城

#import <UIKit/UIKit.h>
#import "ShopDatailViewController.h"
#import "EshopCollectionViewCell.h"
#import "DetaillEViewController.h"
#import "EstoreViewController.h"
@interface EshopViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIScrollView *scrollView;
    UIView *smallView;
    UIView * xiao;
    UICollectionView *_CollectionView;


}
@property (nonatomic,strong) NSMutableArray *postersArr;
@property (nonatomic) NSInteger seletedOn;
@property (nonatomic) NSInteger seletedTop;
@property (nonatomic ,strong) NSMutableArray *imgArr;
@property(nonatomic )BOOL isOne;
@end
