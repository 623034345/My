//
//  BalancePayViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/9.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//     余额支付输入密码

#import <UIKit/UIKit.h>
#import "PaySuccessViewController.h"
#import "OfflineViewController.h"
@interface BalancePayViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *topTX;
    
    NSMutableArray *dataSource;
}
@property(nonatomic, copy)NSString *productId,*buyAmount,*leavemessage;
@property(nonatomic) NSInteger number;
@property(nonatomic, copy)NSString *priceNum;
@property(nonatomic, copy)NSString *saleId;
@property(nonatomic)NSInteger onType;

@end
