//
//  EvaluateViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/1.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           评价列表

#import <UIKit/UIKit.h>
#import "CommentidModel.h"
#import "RatingBar/RatingBarView.h"
@interface EvaluateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RatingBarDelegate>
{
    UITableView *table;
    NSMutableArray *imgArr;
    NSMutableArray *dataArr;
}
@end
