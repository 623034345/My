//
//  AppraiseViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/6.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           商家评价

#import <UIKit/UIKit.h>
#import "RatingBar/RatingBarView.h"
@interface AppraiseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,RatingBarDelegate>
{
    UITableView *table;
    RatingBarView *rating;
}
@end
