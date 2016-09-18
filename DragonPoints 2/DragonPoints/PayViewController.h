//
//  PayViewController.h
//  DragonPoints
//
//  Created by shangce on 16/8/2.
//  Copyright © 2016年 FengYingJie. All rights reserved.
//            支付列表

#import <UIKit/UIKit.h>
#import "PayOneTableViewCell.h"
#import "PayTwoTableViewCell.h"
#import "PayBTableViewCell.h"
#import "AliPayViewController.h"
#import "UPPaymentControl.h"
#import "CashpaymentsViewController.h"
#import "DetailedViewController.h"
#define KBtn_width        200
#define KBtn_height       80
#define KXOffSet          (self.view.frame.size.width - KBtn_width) / 2
#define KYOffSet          80
#define kCellHeight_Normal  50
#define kCellHeight_Manual  145


#define kMode_Development             @"00"

@interface PayViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
}
@property (nonatomic)NSInteger typeOn;//1预售 2立即购买 3买单
@property (nonatomic , copy) NSString *numText;
@property (nonatomic , copy) NSString *buyAmount;


@property (nonatomic , copy) NSString *saleId;
@property (nonatomic , copy) NSString *outTradeNO;
@property (nonatomic , copy) NSString *subject;

@property (nonatomic , copy) NSString *body;

@property (nonatomic , copy) NSString *partner;

@property (nonatomic , copy) NSString *seller;

@property (nonatomic , copy) NSString *privateKey;

@property (nonatomic , copy) NSString *cardName;



@end
