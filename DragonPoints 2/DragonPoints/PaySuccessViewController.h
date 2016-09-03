//
//  PaySuccessViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/9.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//           支付成功

#import <UIKit/UIKit.h>
#import "PreSaleViewController.h"
@interface PaySuccessViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
//    NSDictionary *data;
}
@property(nonatomic, copy)NSString *saleId;
@property(nonatomic, copy)NSString *addition;
@property(nonatomic, copy)NSDictionary *data;
@property(nonatomic, copy)NSString *buyAmount;



@end
