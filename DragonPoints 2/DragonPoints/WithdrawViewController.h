//
//  WithdrawViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/13.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//             银行卡 提现信息确认


#import <UIKit/UIKit.h>

@interface WithdrawViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSDictionary *dataDic;

}
@property(nonatomic, copy)NSString *moneyStr;
@property(nonatomic, copy)NSString *hasBankCard;
@property(nonatomic, copy)NSString *hasZhifubao;

@end
