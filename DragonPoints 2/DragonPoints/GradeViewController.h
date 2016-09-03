//
//  GradeViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/15.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//                 我的等级

#import <UIKit/UIKit.h>
#import "GradeTableViewCell.h"
#import "PayViewController.h"
#import "MembersAgreementViewController.h"
@interface GradeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSMutableArray *dataArr;
    NSDictionary *dataDic;
    
}
@end
