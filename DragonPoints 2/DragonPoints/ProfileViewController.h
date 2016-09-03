//
//  ProfileViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/10.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//          ///收货地址

#import <UIKit/UIKit.h>
#import "ProfileTableViewCell.h"
#import "AddProfileViewController.h"
@interface ProfileViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSMutableArray *dataArr;
    NSInteger _selected;
}
@end
