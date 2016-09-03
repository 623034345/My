//
//  TransactionViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           商家订单

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "XTSegmentControl.h"
#import "MyAppointmentView.h"
#import "TransactTableViewCell.h"
#import "SuccessTableViewCell.h"
#import "ShopOrderModel.h"
@interface TransactionViewController : UIViewController<iCarouselDataSource, iCarouselDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *title;                         // 数组
    iCarousel *carouselD;                   //下方滑动
    XTSegmentControl *segmentControl;       //上方导航
    MyAppointmentView *currentMyAppointmentView;
    NSIndexPath *selectedIndexPath;         //按钮选中的行
    int status;                             //状态
    NSMutableArray *dataArr;             //数据源
    BOOL isRefresh;
    NSDictionary *selectedDic;              //按钮选中行的信息
    NSString *lastModifyDate;
    
}
@property (nonatomic, assign) int selectIndex;
@property(nonatomic) NSInteger type;
@end
