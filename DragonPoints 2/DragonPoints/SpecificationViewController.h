//
//  SpecificationViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/5.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//          选择规格

#import <UIKit/UIKit.h>

@interface SpecificationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSArray *arr;
    UILabel *choosLab;
    NSMutableArray *_btnMutableArray;
    NSMutableArray *_btnMutableArray1;

}
@end
