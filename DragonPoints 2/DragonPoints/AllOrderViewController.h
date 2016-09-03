//
//  AllOrderViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/3.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//             订单详情

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "XTSegmentControl.h"
#import "MyAppointmentView.h"
#import "OrderTableViewCell.h"
#import "JudgeViewController.h"
#import "OrderInfoViewController.h"
#import "RefundViewController.h"
#import "OfflineViewController.h"
#import "EstoreViewController.h"
#import "DetailedViewController.h"
@interface AllOrderViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,BtnClickDelegate>
{
    NSArray *title;                         // 数组
    iCarousel *carouselD;                   //下方滑动
    XTSegmentControl *segmentControl;       //上方导航
    MyAppointmentView *currentMyAppointmentView;
    NSIndexPath *selectedIndexPath;         //按钮选中的行
    NSMutableArray *dataSource;             //数据源
    BOOL isRefresh;
    NSDictionary *selectedDic;              //按钮选中行的信息
    NSString *lastModifyDate;
    UITableView *table;
    
}
@property (nonatomic)  NSUInteger status;                             //状态

@property (nonatomic, assign) NSUInteger selectIndex;
@property (nonatomic, assign) CGSize cardSize; 
@end
