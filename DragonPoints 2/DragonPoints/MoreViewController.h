//
//  MoreViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreTableViewCell.h"
#import "HomeDetailViewController.h"
#import "MoreOneModel.h"
#import "MoreTwoModel.h"
@interface MoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSMutableArray *moreArr;
    NSMutableArray *belArr;
    


}
@property (nonatomic) float cellHeight;
@end
