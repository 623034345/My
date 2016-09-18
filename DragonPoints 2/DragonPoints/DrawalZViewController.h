//
//  DrawalZViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/25.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//            支付宝  提现信息确认

#import <UIKit/UIKit.h>

@interface DrawalZViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    
}
@property(nonatomic, copy)NSString *moneyStr;

@end
