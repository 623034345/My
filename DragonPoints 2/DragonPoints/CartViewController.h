//
//  CartViewController.h
//  DragonPoints
//
//  Created by shangce on 16/7/27.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NcartTableViewCell.h"
#import "OnlineTableViewCell.h"
#import "PayViewController.h"
@interface CartViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;

    NSMutableArray *shopArr;
    NSMutableArray *referralArr;
    //该数组负责记录索引
    NSMutableArray *_selectedArr;
    NSMutableArray *loca;
    float priceNum;
    UILabel *labPrice;
    UIButton *payBtn;
    BOOL All;

}

@end
